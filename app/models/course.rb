class Course < ActiveRecord::Base
	searchkick
	belongs_to :user
	has_many :reviews
	validates_uniqueness_of :code, :message => ' Kurssi kyseisellä kurssikoodilla on jo olemassa! Tarkista palveluun jo lisätyt kurssit.'
	validates_inclusion_of :credits, :in => 1..20, :message => 'Opintopisteet täytyy olla numeerisessa muodossa ja väliltä 1-20!'

end
