module EnumerableRefinements
  refine Enumerable do
    def each_flag_last
      each_with_index do |item, index|
        yield item, (index + 1) == count
      end
    end
  end
end
