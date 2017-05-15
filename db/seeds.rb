forums = ['İNŞAAT', 'BİLİŞİM', 'OTOMOTİV', 'EĞİTİM', 'SANAT', 'SAĞLIK']

forums.each do |forum|
  Forum.find_or_create_by_name(forum)
  puts "- #{forum} forumu oluşturuldu."
end
