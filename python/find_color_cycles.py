#!/usr/bin/env python3

import pydot
import sys
from collections import defaultdict

def find_cycles(graph):
    """Finds all cycles in a directed graph using DFS."""
    visited = set()
    stack = []
    cycles = []

    def dfs(node):
        visited.add(node)
        stack.append(node)
        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                dfs(neighbor)
            elif neighbor in stack:
                # Found a cycle
                cycle_start_index = stack.index(neighbor)
                cycle = stack[cycle_start_index:]
                if cycle not in cycles:
                    cycles.append(cycle)
        stack.pop()

    for node in graph:
        if node not in visited:
            dfs(node)
    return cycles

def dot_to_color_adj_lists(dot_file_path):
    """Parses DOT file and returns adjacency lists grouped by edge color."""
    try:
        graphs = pydot.graph_from_dot_file(dot_file_path)
        if not graphs:
            raise ValueError("No graph found in DOT file.")
        graph = graphs[0]

        color_groups = defaultdict(lambda: defaultdict(list))
        for edge in graph.get_edges():
            src = edge.get_source().strip('"')
            dst = edge.get_destination().strip('"')
            color = edge.get_color() or "black"  # Default color if not set
            color_groups[color][src].append(dst)

        return color_groups, graph
    except Exception as e:
        print(f"Error reading DOT file: {e}")
        sys.exit(1)

def highlight_cycles(original_graph, cycles_by_color, output_path):
    """Highlights cycles for each color in the DOT file."""
    for color, cycles in cycles_by_color.items():
        for cycle in cycles:
            for i in range(len(cycle)):
                src = cycle[i]
                dst = cycle[(i + 1) % len(cycle)]
                for edge in original_graph.get_edges():
                    if (edge.get_source().strip('"') == src and
                        edge.get_destination().strip('"') == dst and
                        (edge.get_color() or "black") == color):
                        edge.set_penwidth(3)
                        edge.set_style("bold")
                        edge.set_color(color)  # Keep original color
    original_graph.write(output_path)
    print(f"Cycle-highlighted DOT file saved to: {output_path}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python find_color_cycles.py <dot_file>")
        sys.exit(1)

    dot_file = sys.argv[1]
    color_adj_lists, graph_obj = dot_to_color_adj_lists(dot_file)

    cycles_by_color = {}
    for color, adj_list in color_adj_lists.items():
        cycles = find_cycles(adj_list)
        if cycles:
            cycles_by_color[color] = cycles
            print(f"\nCycles for color '{color}':")
            for cycle in cycles:
                print(" -> ".join(cycle) + " -> " + cycle[0])

    if cycles_by_color:
        highlight_cycles(graph_obj, cycles_by_color, "highlighted_color_cycles.dot")
    else:
        print("No cycles found for any color.")
