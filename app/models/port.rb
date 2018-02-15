class Port < ActiveRecord::Base

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  tracked :parameters => {
      :server => proc { |controller, model_instance| model_instance.card.try(:server)},
      :card_type => proc { |controller, model_instance| "#{model_instance.card.try(:composant)} #{model_instance.card.try(:card_type)}"},
      :vlans => :vlans
  }

  belongs_to :card

  has_one :connection
  has_one :cable, through: :connection
  has_one :server, through: :card

  scope :sorted, -> {order(:position)}

  def network_conf(switch_slot)
    cable_name = connection.try(:cable).try(:name)
    if cable_name.present?
      "#{connection.cable.try(:color)} - #{cable_name} - Switch #{cable_name[0]} - Port #{switch_slot}:#{cable_name[1..-1]} - #{vlans}"
    end
  end

  def connect_to_port(other_port, cable_name, cable_color, vlans)
    remove_unused_connections([self, other_port])
    if other_port
      cable = nil
      if self.connection.present?
        cable ||= self.connection.cable
      end
      if other_port.connection.present?
        cable ||= other_port.connection.cable
      end
      if cable.present? and !cable.destroyed?
        cable.name = cable_name
        cable.color = cable_color
        cable.save
      else
        cable = Cable.create(name: cable_name, color: cable_color)
      end

      self.connection = Connection.find_or_create_by(port: self, cable: cable)
      other_port.connection = Connection.find_or_create_by(port: other_port, cable: cable)
      self.vlans = vlans
      other_port.vlans = self.vlans

      self.save && other_port.save
    end
  end

  def cablename
    if connection.present? && connection.try(:cable).present? && connection.try(:cable).try(:name).present?
      connection.cable.name
    else
      ""
    end
  end

  def cablecolor
    self.try(:connection).try(:cable).present? ? self.connection.cable.color : ''
  end

  def is_power_input?
    card.is_power_input?
  end

  private

  def remove_unused_connections(ports)
    ports.reject(&:blank?).each do |port|
      old_port_destination = port.connection.try(:paired_connection).try(:port)
      if old_port_destination.present? && !ports.include?(old_port_destination)
        old_port_destination.connection.cable.destroy
      end
    end
  end

end
