class Contact < ApplicationRecord
    belongs_to :kind, optional: true
    has_many :phones
    has_one :address
    accepts_nested_attributes_for :address, update_only: true
    accepts_nested_attributes_for :phones, allow_destroy: true
    def as_json(options={})
        x = super(options)
        x[:birthdate] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
        x
    end

    #-------------------------------
    # def author
    #     "?????"
    # end
    #-------------------------------
    # def kind_description
    #     self.kind.description
    # end
    #-------------------------------
    # def as_json(options={})
    #     # super chama o as_json original
    #    super(
    #         methods: :author, 
    #         methods: :kind_description,
    #         root: true,
    #         except: [:created_at, :updated_at],
    #         include: { kind: { only: [:created_at, :updated_at] } }
    #     )
    # end
    #-------------------------------
    # def br_translation
    #     {
    #         name: self.name,
    #         email: self.email,
    #         birthdate: (I18n.l(self.birthdate) unless birthdate.blank?)
    #     }
    # end
end
