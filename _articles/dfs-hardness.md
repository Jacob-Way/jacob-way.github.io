---
title: "Hardness of Distributed DFS [AI Result]"

category: results
published: false
status: soon
date: 2026-11-15
---
## Lower Bound
This lower bound is based on the strategy of [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049).

## Improved Algorithm
Ghaffari and Parter [[GP '17]](https://groups.csail.mit.edu/tds/papers/Parter/disc17-mohsen.pdf) gave the first improvement over the trivial $O(n)$ bound, with an $\tilde O(n^{3/4}+\sqrt{nD})$ round distributed DFS algorithm. This is based on constructing a collection of paths that constitute a balanced separator of the graph (which was originally used by [[AA '87]](https://dl.acm.org/doi/abs/10.1145/28395.28430)). 

## AI Use
Both the upper and lower bounds discussed in this article were discovered by [ChatGPT-6 Astra](https://chatgpt.com/share/6af9f49f-e40c-83ea-877b-ba100dae1ddc).