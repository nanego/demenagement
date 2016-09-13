class Frame < ActiveRecord::Base

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  has_many :servers, -> { order("servers.position desc") }, dependent: :destroy
  belongs_to :bay
  has_one :islet, through: :bay
  delegate :room, :to => :islet, :allow_nil => true

  default_scope { order(:position) }

  def to_s
    title
  end

  def name_with_room_and_islet
    "#{room.try(:title).present? ? "Salle #{room.title} " : ''} #{bay.present? ? "Ilot #{bay.islet.name}" : ''} Baie #{title.present? ? title : 'non précisée' }"
  end

  def self.to_txt(servers_per_bay)
    txt = ""
    if servers_per_bay.present?
      servers_per_bay.each do |islet, frames|
        frames.each_with_index do |(frame, servers), index|
          txt << "\r\n#{frame.title}\r\n"
          txt << "---------------\r\n"
          servers.each do |server|
            txt << "[#{server.position.to_s.rjust(2, "0")}] #{server.nom}\r\n"
          end
        end
      end
    end
    txt
  end

  def other_frame_through_couple_baie #Temp legacy code
    couples = CoupleBaie.where('baie_one_id = ? OR baie_two_id = ?', self.id, self.id)
    frames = couples.collect(&:baie_one)
    frames << couples.collect(&:baie_two)
    (frames - [self]).first
  end

  def other_frame
    (bay.frames - [self]).first
  end

  def other_frames
    bay.frames - [self]
  end

  def has_coupled_frame?
    bay.frames.count > 1
  end

  def has_no_coupled_frame?
    bay.frames.count == 1
  end

  def compact_u
    self.u = servers.map{|s|s.modele.u}.sum
    self
  end

  private

    def slug_candidates
      [
          :title,
          [self.room.try(:title), :title],
          [self.room.try(:title), :title, :id]
      ]
    end

end
