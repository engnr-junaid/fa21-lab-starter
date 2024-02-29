#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* TODO: Implement ll_has_cycle */
    if (head == NULL) {
        return 0; // No cycle in an empty list
    }

    node *slow_ptr = head; // Slow pointer
    node *fast_ptr = head; // Fast pointer

    // Move fast_ptr two nodes at a time and slow_ptr one node at a time
    while (fast_ptr != NULL && fast_ptr->next != NULL) {
        slow_ptr = slow_ptr->next;         // Move slow_ptr one node
        fast_ptr = fast_ptr->next->next;   // Move fast_ptr two nodes
        // If they meet at some point, there's a cycle
        if (slow_ptr == fast_ptr) {
            return 1; // Cycle detected
        }
    }

    // If fast_ptr reaches the end of the list, no cycle found
    return 0;

}

