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
    elsif money =="usd_eur"
      Cambio.current_dolar_euro
    end
  end

  def self.current_peso_dolar
    category = CategoriaCambio.peso_dolar
    category.cambios.no_bsp.parent_id
  end

  def self.current_peso_euro
    category = CategoriaCambio.peso_euro
    category.cambios.parent_id.no_bsp
  end

end
