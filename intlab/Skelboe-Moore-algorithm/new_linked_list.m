function [list,first_free_ind] = ...
    new_linked_list(max_num_entries, val)
% [list,head,tail,first_free_ind] = ...
%    new_linked_list(max_num_entries, val, level)
% This function returns the structure list with num_entries
% entries and components free, prev, next, value, rank.  This
% is for a linked list, with head at location 1 in the
% and tail also located at 1.  free is initialized to 'true'
% for all entries, 'prev' is initialized to 0 for all,
% and next is initialized to '0' for all.  To initialize
% the data with the proper type, 'value' is initialized to
% 'val' for every element of the list.  The order of each
% item inserted into the list is in order of increasing rank.
% This routine initializes each 'rank' to 0. 
% The tail of the list is detected by next=0.

% Ralph Baker Kearfott, 2008/06/14 -- for the 
% Moore / Kearfott /  Cloud book.

if (max_num_entries < 2)
    disp('Error in new_linked_list: max_num_entries must be');
    disp('greater than or equal to 2.')
    return
end
list(1:max_num_entries) = struct('free',1,'prev',0,'next',0,...
    'value',val,'rank',0);
first_free_ind = 1;
list(1).rank = -realmax;



