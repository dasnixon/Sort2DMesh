class Sort2DMesh
  def initialize
    @mesh = [[6, 1, 5, 7],[3, 9, 5, 8], [4, 2, 9, 3],[1, 6, 3, 8]]
  end

  def sort_mesh
    print_mesh("Initial mesh:")
    0.upto(Math.log2(@mesh.length**2)) do |x| #goes from 0 upto log_2_n: where n is 16, so upto 4 in this case
      if x % 2 == 0 #if even value of x do the even odd row sort and print out the resulting mesh
        even_odd_row_sort(@mesh.length**2)
        print_mesh("Even odd row sort:")
      else #if odd value of x do the even odd column sort and print out the resulting mesh
        even_odd_column_sort(@mesh.length**2)
        print_mesh("Even odd column sort:")
      end
    end
    print_mesh("Final mesh:") #after performing the even odd row/column sorts print out the final mesh
    print_snake #prints out a string in snake order
    discussion
  end

  def even_odd_row_sort(n)
    Math.log2(n)-2.times do #q-2 times we iterate through our rows in parallel to sort
      0.upto(Math.log2(n)-1) do |row| #do in parallel
        if row % 2 == 0
          0.upto(2) do |col|
            if @mesh[row][col] >= @mesh[row][col+1]
              temp = @mesh[row][col+1]
              @mesh[row][col+1] = @mesh[row][col]
              @mesh[row][col] = temp
            end
          end
        else
          0.upto(2) do |col|
            if @mesh[row][col] <= @mesh[row][col+1]
              temp = @mesh[row][col+1]
              @mesh[row][col+1]= @mesh[row][col]
              @mesh[row][col] = temp
            end
          end
        end
      end
    end
  end

  def even_odd_column_sort(n)
    Math.log2(n)-2.times do #q-2 times we iterate through our columns in parallel to sort
      0.upto(Math.log2(n)-1) do |col| #do in parallel
        if col % 2 == 0
          0.upto(2) do |row|
            if @mesh[row][col] >= @mesh[row+1][col]
              temp = @mesh[row+1][col]
              @mesh[row+1][col] = @mesh[row][col]
              @mesh[row][col] = temp
            end
          end
        else
          0.upto(2) do |row|
            if @mesh[row][col] >= @mesh[row+1][col]
              temp = @mesh[row+1][col]
              @mesh[row+1][col]= @mesh[row][col]
              @mesh[row][col] = temp
            end
          end
        end
      end
    end
  end

  def print_mesh(message)
    puts "#{message}"
    @mesh.each_index do |row|
      @mesh.each_index do |column|
        print "#{@mesh[row][column]}"
      end
      puts
    end
  end

  def print_snake
    puts "Snake order:"
    snake_string = ""
    0.upto(3) do |x|
      if x % 2 == 0
        0.upto(3) do |col|
          snake_string << "#{@mesh[x][col]}, "
        end
      else
        3.downto(0) do |col|
          snake_string << "#{@mesh[x][col]}, "
        end
      end
    end
    puts "#{snake_string[0..-3]}"
  end

  def discussion
    puts "For the sorting a 2D mesh the W(n) = sqrt(n)*log(n). Each row and column sort costs us only 1 step\nsince they are run in parallel. These parallel sorts have no meaningful effect on the complexity. The logn"
    puts "comes from the initial loop in the sort_mesh function (line 8). We loop from 0 to log2(n). The sqrt(n)\ncomes from lines 23 and 47. In order to make sure we compare every value in each row and column"
    puts "we have to do q-2 iterations of parallel sorting. Therfore this gives us a total of q iterations.\nWell, n = q^2, and so sqrt(n) = q. With q iterations this is how are W(n) complexity is sqrt(n)*log(n)"
  end
end

Sort2DMesh.new.sort_mesh
