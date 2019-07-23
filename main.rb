require "./node.rb"

def build_tree(array)
    base_node = Node.new(array[0])
    array.each_with_index do |num, index|
        next if index == 0
        new_node = Node.new(num)
        search_node = base_node
        loop do
            break if search_node.right_child.nil? && num > search_node.value
            break if search_node.left_child.nil? && num <= search_node.value
            if num > search_node.value
                search_node = search_node.right_child
            else
                search_node = search_node.left_child
            end
        end
        new_node.parent = search_node
        search_node.left_child = new_node if num <= search_node.value
        search_node.right_child = new_node if num > search_node.value
    end
    base_node
end

def breadth_first_search(base_node, value=nil)
    queue = [base_node]
    loop do
        break if queue.empty?
        current_node = queue.shift
        return current_node if current_node.value == value
        queue << current_node.left_child if !current_node.left_child.nil?
        queue << current_node.right_child if !current_node.right_child.nil?
    end
    nil
end

def depth_first_search(base_node, value=nil)
    return nil if base_node == nil
    stack = [base_node]
    visited = []
    loop do
        break if stack.empty?
        current_node = stack[-1]
        visited << current_node
        return current_node if current_node.value == value
        if current_node.left_child && !visited.include?(current_node.left_child)
            stack << current_node.left_child
        elsif current_node.right_child && !visited.include?(current_node.right_child)
            stack << current_node.right_child
        else
            stack.pop
        end
    end
    nil
end

def dfs_rec(base_node, value=nil)
    return if base_node == nil
    return base_node if base_node.value == value
    left_branch = dfs_rec(base_node.left_child, value)
    right_branch = dfs_rec(base_node.right_child, value)
    left_branch || right_branch
end


#ordered array
tree = build_tree([1,3,4,4,5,7,7,8,9,23,67,324,6345])
p breadth_first_search(tree, 7)
p breadth_first_search(tree, 55)
p depth_first_search(tree, 9)
p depth_first_search(tree, 99)
p dfs_rec(tree, 9)
p dfs_rec(tree, 101)

#unordered aray
tree = build_tree([23,4,4,5,7,7,8,1,3,9,67,6345,324])
p breadth_first_search(tree, 7)
p breadth_first_search(tree, 55)
p depth_first_search(tree, 9)
p depth_first_search(tree, 99)
p dfs_rec(tree, 9)
p dfs_rec(tree, 101)
