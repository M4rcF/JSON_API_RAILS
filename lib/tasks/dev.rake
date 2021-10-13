namespace :dev do
  desc "Cadastra contatos"
  task setup: :environment do
    spinner("Droping db...") { %x(rails db:drop:_unsafe) }
    spinner("Creating db...") { %x(rails db:create) }
    spinner("Migrating db...") { %x(rails db:migrate) }
    spinner("Generating kinds...") { add_kinds }
    spinner("Generating contacts...") { add_contacts }
    spinner("Generating phones...") { add_phones }
    spinner("Generating addresses...") { add_addresses }
  end

  private 

  #Spinner
  def spinner(msg)
    spinner = TTY::Spinner.new("[:spinner] #{msg}")
    yield
    spinner.success("(Successful)")
  end

  #Generating contacts

  def add_contacts
    5.times do 
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 50.days.ago, to: 18.days.ago),
        kind: Kind.all.sample
      )
    end 
  end

  #Generating kinds

  def add_kinds
      kinds = %w(Amigo Comercial Conhecido)
      kinds.each do |kind|
        Kind.create!(
          description: kind
        )
      end
  end

  #Generating phones

  def add_phones
    Contact.all.each do |contact|
      3.times do 
        Phone.create!(
          number: Faker::PhoneNumber.cell_phone,
          contact: contact
        )
      end
    end
  end

  #Generating adresses

  def add_addresses
    Contact.all.each do |contact|
      Address.create!(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end
end
end
