---
title: "MWC in Sparse Graphs"
category: results
published: true
date: 2026-08-28
---

This article introduces the complexity gap for the minimum-weight cycle problem. Specifically, the existing $\Omega(n)$ lower-bound for exact MWC only holds in dense graphs. In sparse graphs, existing methods obtain at best a lower-bound of $\Omega(D+\sqrt{m}+n^{2/3})$ rounds.

## Introduction

**Minimum-Weight Cycle** asks for every node to learn the size of the shortest cycle in the graph. This is called **girth** in the unweighted undirected context.

**All-Nodes Shortest Cycle** asks for every node to learn the size of the shortest cycle it is in.

MWC can be solved by solving ANSC, then using one global aggregation and broadcast. However, some variants of ANSC are local problems taking $o(D)$ rounds. For example, in an unweighted undirected graph, ANSC can be solved efficiently when every node is in a short cycle (e.g., via triangle detection [[CPSC '21]](https://par.nsf.gov/servlets/purl/10297722)). 

<!-- In a directed weighted graph, ANSC can be solved in each SCC independently, regardless of the overall diameter of $G$, since no cycle can pass between SCCs. -->

Both problems are closely related to the all-pairs shortest-paths (APSP) problem.

**Directed APSP Reduction:** Suppose APSP has been solved in a directed graph. Then for a node $v$, the minimum-weight cycle including $v$ has weight

$$\min_{u\in N(v)}d(v,u)+w(u,v)$$

which can be computed locally. A global minimum can be aggregated using a BFS tree.

**Undirected APSP Reduction:** Suppose APSP has been solved in an undirected graph. Every node knows its distances to other nodes, which are held in an $O(n\log n)$-bit distance table. If every node sends this table to all of its neighbors, any node $v$ can compute the shortest cycle it is in in the following way: for every $u$ adjacent to $v$, determine the minimum weight cycle containing both, then minimize over $u$. That is, the min-weight cycle including $v$ has weight
$$\min_{u\in N(v)}\left[\min_{w\not =u,v}d(v,w)+d(w,u)+w(u,v)\right]$$

For this reason, the (deterministic) unweighted APSP algorithm of Holzer and Wattenhofer [[HW '12]](https://tik-db.ee.ethz.ch/file/3addb87bcaf363395932dcb5773771e6/) solves unweighted girth in $O(n)$ rounds. The (Las Vegas) weighted APSP algorithm of Bernstein and Nanongkai [[BN '19]](https://arxiv.org/abs/1811.03337) solves weighted girth in $\tilde O(n)$ rounds.


## Previous Work
- [Frishknecht, Holzer, Wattenhofer '12](https://tik-old.ee.ethz.ch/file/9760424efc65482a92becb44265a76d8/SODA2012.pdf) prove an $\tilde \Omega(\sqrt{n})$ lower bound for girth.



- [Agarwal '23](https://arxiv.org/abs/2310.00782) provided a deterministic algorithm for exact MWC using $\tilde O(n)$ rounds. This also solves exact ANSC and exact SSSP from $\sqrt{n}$ sources using the same round complexity. Importantly, this complexity is achieved without solving APSP deterministically. The latter is still an open problem.
- In 2026, two papers independently improved the bounds for approximating MWC. [CCDJMNY '26](https://arxiv.org/abs/2603.25368) and [Chechik, Lifschitz, Mukhtar '26](https://arxiv.org/abs/2603.27601). These also give new lower-bounds.

## Lower Bounds

### Girth Lower-Bound

This bound relies on a reduction to distributed set-disjointness. At a high level, Alice and Bob both have two copies of a graph $H$ with $k$ nodes: Alice has $A_1,A_2$ and Bob has $B_1,B_2$. Corresponding nodes in $A_i,B_i$ are connected by a single edge. Alice and Bob generate a message of length $k^2$ bits. 

Each bit can be used to encode the length of a path between $A_1$ and $A_2$ ($B_1$ and $B_2$ resp.). When the bit is 1, we add a path of length $2$ between the corresponding pair in $A_1\times A_2$. Otherwise, we add a path of length $8$.

When Alice and Bob's messages agree in any bit, there is a cycle of length $6$ in $G$ consisting of their added paths, plus the edges between the two players. Otherwise, the smallest cycle on Alice's side alone must have length at least 8 since $A_1$ and $A_2$ are bipartite, so the cycle must consist of at least 4 short paths. Assuming disjointness, the smallest cycle passing between Alice and Bob must either use a long path or use two extra short paths. In either case, the path will have length $10$ at least.

Therefore, the players' messages are disjoint iff $G$ has girth $>6$. Since each added path adds $O(1)$ nodes, $G$ has $O(k^2)$ nodes. Since $k^2$ bits need to be transmitted across a cut of size $k$, this implies a round-complexity lower-bound of $\tilde \Omega(\sqrt{n})$.

This lower-bound graph has diameter $O(1)$, and $O(n)$ edges


<!-- The idea of the reduction is that verifying that such a cycle does not exist is equivalent to verifying the disjointness of the two players' messages.

For the weighted lower-bound, we can assign a weight of $\infty$ to the edges within each of the four copies of $H$. Crossing edges are given weight 1 and message-encoding edges are given weight. In this graph, whenever the two messages are disjoint, the minimum-weight cycle 

, then the MWC has size $>4$ iff Alice and Bob's messages are disjoint. -->

### MWC Lower Bound for Dense Graphs
Manoharan and Ramachandran [[MR '22]](https://arxiv.org/abs/2205.14797) proved an $\tilde \Omega(n)$ lower bound for exact undirected MWC.

The idea is that instead of using long/short paths to encode bits, we can use edges. Since edges do not increase the node count of $G$, $G$ will have $O(k)$ nodes rather than $O(k^2)$. This directly leads to an $\tilde \Omega(n)$ lower bound on MWC.

However, the bound is now dependent on the density of $G$: if $G$ has $m$ edges, this lower bound is reduced to $\tilde \Omega(m/n)$, since if the two messages have only $O(m)$ nonzero bits, distributed set-disjointness can be decided by transmitting $O(m)$ bits across the cut of size $O(n)$. 

### Lower Bound for Sparse Graphs

[[CCDJMNY '26]](https://arxiv.org/abs/2603.25368) proves an $\tilde \Omega(D+n^{2/3})$ lower bound for every $2-\epsilon$ approximation algorithm. Importantly, this applies even in sparse graphs.

The idea is to replace the cut-crossing edges of the previous bound by (zero-weight) paths of length $O(n/k)$. If we also add a heavy-weight overlay graph, the diameter can be kept low. Then, using the same method as [DHKKNPPW '10](https://arxiv.org/abs/1011.3049), we can prove a lower bound of $\Omega(\min(k^2,n/k))$ rounds for solving MWC. Taking $k=n^{1/3}$ gives $\Omega(n^{2/3})$ rounds, and the resulting graph has $O(n)$ edges.

### New Lower Bound for Sparse Graphs

Alternatively, we can construct a graph with $m$ edges in which MWC takes $\tilde \Omega(\sqrt{m})$ rounds. To do this, start with the dense-graph lower-bound, but use $k=\sqrt{m}$. The lower-bound graph uses $O(m)$ edges to encode an $m$-bit message, and this message must cross a cut of size $O(\sqrt{m})$, forcing $\tilde \Omega(\sqrt{m})$ round complexity.

## Open Questions
- Is there an $\tilde \Omega(n)$ lower-bound for exact MWC, even in sparse graphs?
- Is there an exact MWC algorithm with $o(n)$ round complexity in sparse graphs?
- What is the complexity of Girth? A lower-bound of $\tilde \Omega(D+\sqrt{n})$ and an upper-bound of $\tilde O(n)$ rounds are known.

<!-- ### New Lower Bounds for Sparse Graphs

Interestingly, there is a round-message tradeoff lower-bound for the MWC problem in sparse graphs:

First, consider the lower-bound graph of [CCDJMNY '26](https://arxiv.org/abs/2603.25368): Alice and Bob each have $k$ nodes and $O(k^2)$ bit messages, and there are paths of length $n/k$ connecting corresponding nodes on Alice's and Bob's sides. 

First, use $k=\sqrt{n}$. Then there are $\sqrt{n}$ paths of length $\sqrt{n}$ crossing the cut. To exhibit the tradeoff lower-bound, reduce the length of the $i$'th crossing path to $i$.

Since $n$ bits need to cross the cut, achieving $t$ round complexity necessitates $t$ edge-congestion. This means that at least $n/t$ paths need to be used. If we use $n/t$ paths, they will have an average length of at least $\Theta(n/t)$. -->

<!-- In this graph, we can choose $k=\sqrt{n}$. This means that $n$ bits need to cross the cut. Also, for any $p<1$, $\Theta(p\sqrt{n})$ paths have a length shorter than $p\sqrt{n}$, and their average length is $\Theta(p\sqrt{n})$. 



For $O(n)$ bits to cross within $O(n^{1/2+\epsilon})$ rounds, they need to use at least $O(n^{1/2-\epsilon})$ paths, preferrably the shortest ones. These $O(n^{1/2-\epsilon})$ shortest paths have an average length of $\Theta(n^{1/2-\epsilon})$, meaning that transmitting $n$ bits uses $\Omega(n^{3/2-\epsilon})$ messages. -->


<!-- 
**Claim:** There is a graph with $n$ nodes, $m$ edges, and diameter $O(n/\sqrt{m})$ in which solving MWC requires $\Omega(n\sqrt{m})$ messages, regardless of rounds.

**Claim:** There is a graph with $n$ nodes, $m$ edges, and constant diameter in which solving exact MWC takes $\Omega(\sqrt{m}+n^{2/3})$ rounds.

### Other Lower-Bound Ideas

All-Nodes Shortest-Cycle may be harder than MWC

## Upper Bounds

In general, MWC can be solved within $O(m)$ rounds and $O(mD)$ messages, where $D$ is the graph diameter.

### Ideas

One idea is as follows: Roddity/Williams have proven a reduction from MWC to minimum-weight triangle. Minimum-weight triangle may be solvable easily in an expander using a method similar to triangle detection. -->