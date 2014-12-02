#!/bin/env ruby
# encoding: utf-8
class Cambio < ActiveRecord::Base
  
  
  default_scope { order('date_start DESC') }

  scope :bsp,       -> { where("description LIKE ?", "%BSP%") }

  scope :no_bsp,    -> { where("description NOT LIKE ?", "%BSP%") }

  scope :parent_id, -> { where(" parent_id= ?",  -1) }

  def self.currency money
    if  money == "usd" 
      Cambio.current_peso_dolar
    elsif money =="eur"
      Cambio.current_peso_euro
    end
  end

  def self.current_peso_dolar
    category = CategoriaCambio.peso_dolar
    p category
    category.cambios.no_bsp.parent_id
  end

  def self.current_peso_euro
    category = CategoriaCambio.peso_euro
    category.cambios.parent_id.no_bsp
  end


#   cattr_reader :per_page
#   @@per_page = 2


#   named_scope :is_deleted , lambda { |value|
#     { :conditions=>['is_deleted =? ', value]}
#   }
#   named_scope :get_value_for , lambda { |father, date|
#     { :conditions=>[
# "((id =?  and parent_id =-1 and \'#{date}\' between date_start and date_end)
# or
# (parent_id  = ? and \'#{date}\' between date_start and date_end)
# or
# (id = ? and date_start <= \'#{date}\' and date_end is not null)
# or
# (id = ? and date_start between  \'#{date}\ 00:00' and  \'#{date}\ 23:59'))",  father.id,father.id,father.id,father.id]}
#   }


#   named_scope :sons, lambda{ |father|
#     { :conditions=>['parent_id =? ',father.id]}
#   }


  # def self.current_bsp_change
  #   pd_category = CategoriaCambio.peso_dolar
  #   pd_category.cambios.fathers.bsp.first
  # end

  # # => COTIZADOR HOTELES --Cambio utilizado para el cotizador HOTELES #FareLines->StaticFares

  # def self.latest_peso_dolar
  #   pd_category = CategoriaCambio.peso_dolar
  #   pd_category.cambios.fathers.not_bsp.first.value
  # end

  # def self.latest_dolar_peso
  #   1/self.latest_peso_dolar 
  # end


  # def self.latest_euro_peso
  #   1/self.latest_peso_euro
  # end

  # def self.latest_dolar_euro
  #   pd_category = CategoriaCambio.dolar_euro
  #   pd_category.cambios.fathers.not_bsp.first.value
  # end

  # def self.latest_euro_dolar
  #   1/self.latest_dolar_euro
  # end

  # # => COTIZADOR HOTELES --Cambio utilizado para el cotizador HOTELES #FareLines->StaticFares
  # def as_json(options)
  #   return {
  #     :value=>value,
  #     :date_start => get_formated_date_or_blank(date_start),
  #     :date_end => get_formated_date_or_blank(date_end)
  #   }
  # end

  # def get_formated_date_or_blank date
  #   !date.blank? ? date.strftime('%d/%m/%Y %H:%M:%S'):"-"
  # end

  # def self.fathers_ids
  #   fathers.map(&:id)
  # end

  # def self.last_updated(fathers)
  #   find_by_sql( "SELECT * from(SELECT * FROM `cambios` WHERE parent_id in (#{fathers.join(" ,")})   order by created_at DESC ) as c group by  c.parent_id")
  # end

  # def self.last_updated_paginate(fathers, page, per_page)
  #   sql =  "(SELECT * from(SELECT * FROM `cambios` WHERE parent_id in (#{fathers.join(" ,")})   order by created_at DESC ) as c group by  c.parent_id) order by created_at DESC"
  #   paginate_by_sql(sql, :page => page, :per_page => per_page)
  # end

  # def self.history_for(cambio , cambios=[cambio])
  #   if cambio.parent_id == -1
  #     return cambios
  #   else
  #     cambio = self.find(cambio.parent_id)
  #     cambios << cambio
  #     history_for(cambio, cambios)
  #   end
  # end
  # #  belongs_to :categoria_cambio, :class_name => "CategoriaCambio", :foreign_key => "categoria_cambio"
  # def categoria
  #   return CategoriaCambio.find(self.categoria_cambio)
  # end

  # def value_for_front
  #   self.value.to_s.gsub(".", ",")
  # end

  # def valid_at?(date)
  #    date_end.blank? || ((date_start.to_date .. date_end.to_date).cover?(date))
  # end

  # def self.all_valid_at_for_father(date, father)
  #   #todo implode all Cambio.
  #   cambios = sons(father)
  #   cambios << father if father.date_start.to_date == date
  #   cambios.select{ | c | c.valid_at?(date) }.sort { | a, b | a.date_start <=> b.date_start}
  # end
end
