#!/bin/env ruby
# encoding: utf-8

class CategoriaCambio < ActiveRecord::Base
  has_many :cambios , :class_name => "Cambio", :foreign_key => "categoria_cambio"
  
  def self.peso_dolar
    self.find_by_name("Peso / Dolar")
  end

  def self.peso_euro
    self.find_by_name("Peso / Euro")
  end

  def self.dolar_euro
  	self.find_by_name("Dolar / Euro")
  end

end
