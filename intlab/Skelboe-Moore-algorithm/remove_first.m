function [result, size, list, first_free_ind] = ...
    remove_first(list, max_entries, first_free_ind)
% [result, list, max_entries, first_free_ind} = ...
%     remove_first(list,max_entries,first_free_ind, val, size)
% removes the first entry from list and puts it in result, 
% puts its rank in size, then updates list and first_free_ind.

% Ralph Baker Kearfott, 2008/06/14 -- for the 
% Moore / Kearfott /  Cloud book.

if (~list(1).next)
    disp('Error in remove_first: list is empty.');
    return
end
current_ind = list(1).next;
result = list(current_ind).value;
size = list(current_ind).rank;
list(1).next = list(current_ind).next;
list(current_ind).free = 1;
list(current_ind).prev = 0;
list(current_ind).next = 0;
if (current_ind < first_free_ind)
    first_free_ind = current_ind;
end
    



