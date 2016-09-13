json.array!(@servers) do |server|
  json.extract! server, :id, :localisation_id, :armoire_id, :category_id, :nom, :nb_elts, :architecture_id, :u, :marque_id, :modele_id, :numero, :conso, :cluster, :critique, :domaine_id, :gestion_id, :acte_id, :room_id, :islet, :fc_total, :fc_utilise, :rj45_total, :rj45_utilise, :rj45_futur, :ipmi_utilise, :ipmi_futur, :rg45_cm, :ipmi_dedie
  json.url server_url(server, format: :json)
end
