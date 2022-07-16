function [list,max_entries,first_free_ind] = ...
    insert(list, max_entries, first_free_ind, val, size)
% [list,max_entries,first_free_ind] = ...
%    insert(list,max_entries,first_free_ind, val, size)
% inserts value into list at index first_free_index, between
% existing entries with rank less than size and rank >= size
% max_num_entries is increased as necessary.

% Ralph Baker Kearfott, 2008/06/14 -- for the 
% Moore / Kearfott /  Cloud book.

% Initialize list if it is empty --
if(list(1).free)
    list(1).free = 0;
    list(1).next = 2;
    check_next = 0;
    current_ind = 1;
    first_free_ind = 2;
    next_ind = 0;
else
    check_next = 1;
    current_ind = 1;
    next_ind = list(1).next;
end

% Determine where to insert --
% current_ind will be the index after which to insert.
% next_ind will be the index before which to insert.
while(check_next)
    if(list(current_ind).next == 0)
        check_next = 0;
    end
    if(check_next ~=0)
        if(size < list(current_ind).rank)
            check_next = 0;
            current_ind = old_curr_ind;
            next_ind = old_next_ind;
        end
    end
    if (check_next~=0)
        if(list(current_ind).next ~=0)
           old_curr_ind = current_ind;
           old_next_ind = next_ind;
           current_ind = next_ind;
           next_ind = list(current_ind).next;
        end
    end
end

% Insert at the first free index --
list(current_ind).next = first_free_ind;
list(first_free_ind).prev = current_ind;
list(first_free_ind).next = next_ind;
list(first_free_ind).value = val;
list(first_free_ind).rank = size;
list(first_free_ind).free = 0;
if (next_ind ~= 0)
    list(next_ind).prev = first_free_ind;
end

% Find the new first free index, allocating a new
% block of storage (doubling the amount) as necessary --
new_ind = first_free_ind;
i=new_ind+1;
while (i <= max_entries && ~list(i).free)
    i = i+1;
end
first_free_ind = i;
if (i > max_entries)
    [tl,ffi] = new_linked_list(max_entries, list(1).value);
    list(i:i+max_entries-1) = tl;
    max_entries = 2*max_entries;
end


        
