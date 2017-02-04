# frozen_string_literal: true

require_relative 'enumerable_refinements'

module Plotter
  using EnumerableRefinements

  def self.plot_tree(item)
    new_line = "\n"

    str = String.new
    str << (item.label + new_line)

    item.children.each_flag_last do |child, last|
      prefix = last ? '└─ ' : '├─ '
      str << (prefix + child.label + new_line)
    end

    str
  end
end
