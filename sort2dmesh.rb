class Sort2DMesh
  def initialize
    #creates our initial mesh as an instance variable to be used throughout our class
    @mesh = [[6, 1, 5, 7],[3, 9, 5, 8], [4, 2, 9, 3],[1, 6, 3, 8]]
  end

  def sort_mesh
    print_mesh("Initial mesh:") #prints out the intial mesh
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
    discussion #prints out a discussion of the complexity of the sort2dmesh
  end

  def even_odd_row_sort(n)
    Math.log2(n).to_i.times do #q times we iterate through our rows in parallel to sort
      0.upto(Math.log2(n)-1) do |row| #do in parallel
        if row % 2 == 0
          0.upto(2) do |col|
            if @mesh[row][col] > @mesh[row][col+1]
              temp = @mesh[row][col+1] #holds a temp value to be exchanged
              @mesh[row][col+1] = @mesh[row][col]
              @mesh[row][col] = temp
            end
          end
        else
          0.upto(2) do |col|
            if @mesh[row][col] < @mesh[row][col+1]
              temp = @mesh[row][col+1] #holds a temp value to be exchanged
              @mesh[row][col+1]= @mesh[row][col]
              @mesh[row][col] = temp
            end
          end
        end
      end
    end
  end

  def even_odd_column_sort(n)
    Math.log2(n).to_i.times do #q times we iterate through our columns in parallel to sort
      0.upto(Math.log2(n)-1) do |col| #do in parallel
        if col % 2 == 0
          0.upto(2) do |row|
            if @mesh[row][col] > @mesh[row+1][col]
              temp = @mesh[row+1][col] #holds a temp value to be exchanged
              @mesh[row+1][col] = @mesh[row][col]
              @mesh[row][col] = temp
            end
          end
        else
          0.upto(2) do |row|
            if @mesh[row][col] > @mesh[row+1][col]
              temp = @mesh[row+1][col] #holds a temp value to be exchanged
              @mesh[row+1][col]= @mesh[row][col]
              @mesh[row][col] = temp
            end
          end
        end
      end
    end
  end

  #prints out the mesh and a given message
  def print_mesh(message)
    puts "#{message}"
    @mesh.each_index do |row|
      @mesh.each_index do |column|
        print "#{@mesh[row][column]}"
      end
      puts
    end
  end

  #prints out a string of the snake order of the final mesh
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

  #discusses the sort2dmesh function and the complexity
  def discussion
    puts "For the sorting a 2D mesh the W(n) = sqrt(n)*log(n) + sqrt(n). EvenOddRowSort (line 23) and\nEvenOddColumnSort (line 47) each perform sqrt(n) parallel comparison steps."
    puts "The Sort2dMesh or in our case sort_mesh (line 7) function itself involes log_2_(n) + 1 steps.\nThis is how we get the worst case complexity as mentioned before."
  end
end

Sort2DMesh.new.sort_mesh
