---
title: "Universally Optimal and Message-Optimal Algorithms for Known Topologies"
category: results
published: false
status: in-progress
date: 2026-01-28
---

This article answers an open question raised by Haeupler, Wajc, and Zuzic [[HWZ '21]](https://arxiv.org/abs/2104.03932), namely: can the partwise aggregation problem be solved using a near-universally optimal number of rounds and a near-optimal number of messages simultaneously in the supported-CONGEST model? It also gives a simple, self-contained explanation of the near-universally optimal partwise-aggregation algorithm in that paper.

## Model and Preliminaries

The supported CONGEST model assumes each node has initial knowledge of the network topology. This is not standard, but is used in this case since it demonstrates a tight upper bound on the complexity of partwise aggregation which would be much more complicated without topology knowledge. This is valuable since previous work [[FKRS '19]](https://arxiv.org/abs/1905.03012) has shown that topology knowledge does not reduce lower-bounds for a wide class of graph optimization problems. Thus, the existence of a tight algorithm in supported CONGEST suggests that the same lower-bound for partwise aggregation may be tight in the standard CONGEST model.


To define the model rigorously, let $H$ be a communication network and $G\subseteq H$ be a subgraph on which a problem must be solved. The supported CONGEST model assumes each node has initial knowledge of the topology of $H$, but not of $G$ or of the problem-specific input (e.g., edge weights, node weights, etc.). [[HWZ '21]](https://arxiv.org/abs/2104.03932) shows that a quantity they call the *shortcut quality* $Q(H)$ of $H$ is a universal lower bound on the complexity of solving many distributed problems defined on subgraphs $G\subseteq H$, in both the supported and standard CONGEST models. It also introduces a $\tilde O(Q)$-round, $\tilde O(nQ+m)$-message supported-CONGEST algorithm for the problem of partwise aggregation --- this implies algorithms with the same complexity for various other supported-CONGEST problems via the Minor-Aggregation model [[ZGYHS '21]](https://arxiv.org/abs/2110.15944).

To review, we define shortcuts and shortcut quality.

**Definition 1 [Shortcuts]:** Let $G=(V,E)$ be a graph, and let $\mathcal{P}=(P_1,...,P_k)$ be a collection of disjoint connected vertex sets. A shortcut with dilation $d$ and congestion $c$ is a collection $\mathcal{H}=(H_1,...,H_k)$ with each $H_i\subseteq E$ such that:
- The edges of $H_i$ reduce the diameter of $P_i$ to $d$: for every $i$, $u,v\in P_i$, $\dist_{G[P_i]\cup H_i}(u,v)\leq d$.
- Every edge is in at most $c$ shortcut sets: $\max_{e\in E}\abs{\{i:e\in H_i}\}\leq c$.

Shortcuts may also be defined for a *connectable* set of vertex pairs, that is, a set for which a node-disjoint partition exists such that each pair is in the same part and different pairs are in different parts.

**Definition 2 [Shortcut Quality]:** The *shortcut quality* of a graph $G$ is the worst possible congestion plus dilation of shortcuts, over all possible (connected) partitions. That is:
$$Q(G):=\max_{\text{partitions }\mathcal{P}} \min_{\text{shortcuts }\mathcal{H}}[c(\mathcal{H})+d(\mathcal{H})]$$

Haeupler, Wajc, and Zuzic also define $Q_2(G)$ in a similar way, but instead for shortcuts of connectible pairs, and prove that $Q=\tilde \Theta(Q_2)$. They also prove that this quantity is a tight bound on the complexity of solving partwise-aggregation on $G$, assuming initial topology knowledge.

## Review of Haeupler, Wajc, and Zuzic

To prove their upper bound, they start with an algorithm for constructing shortcuts for connectable node pairs.

**Theorem 1** (based on [[HWZ '21]](https://arxiv.org/abs/2104.03932), Lemma 7.1). Let $G=(V,E)$ be a connected graph with shortcut quality $Q$. There exists a randomized supported-CONGEST algorithm (with shared randomness and communication network $H\supset G$) that takes as input $k$ connectable pairs $S=\{(s_i,t_i)\}_{i=1}^{k}$, where each endpoint initially knows its partner but need not know the other pairs. The algorithm constructs a shortcut for $S$ of quality $\tilde O(Q)$ in $\tilde O(Q)$ rounds and $\tilde O(kQ+m)$ messages, with high probability.

*Proof:* This algorithm is exactly the same as in [[HWZ '21]](https://arxiv.org/abs/2104.03932). We just analyze its message complexity. The idea is to route a message from each $s_i$ to its corresponding $t_i$ using $\tilde O(Q)$ rounds. Due to the fact that congestion plus dilation bounds the time needed to route messages on these paths, the routes can be used as shortcuts with quality $\tilde O(Q)$.

First, we assume all nodes know a value $\tilde Q$ which is a $2$-approximation of $Q$. Each node uses this parameter to construct a $\tilde Q$-hop oblivious routing scheme $R^h$ locally based on its knowledge of the topology of $H$. This scheme has polylogarithmic hop and congestion stretch. Using shared randomness, each node samples a path $p_{s,t}$ for every possible pair $(s,t)$. Thus, intermediate nodes can route packets from $s$ to $t$ along this shared path.

Next, each endpoint sends a packet along this path to its target endpoint for $O(\log^7n)$ steps (after delaying each by a random delay in $[0,\Theta( Q\log^7n)]$). To deliver packets, we split time into $O(\log n)$-round super-rounds. Our chosen paths have congestion $O(Q\log^7n)$, so each edge will be crossed by $O(\log n)$ packets per super-round (with high probability). Each node forwards these packets in order. After routing packets for $O(Q\log^8n)$ rounds, we route them in the opposite direction and use one convergecast on a BFS spanning tree to detect failures using $O(D)$ rounds and $O(m)$ messages.

If $Q$ is not known in advance, we run this procedure with progressively doubling estimates $\tilde Q=1,2,4,...$. When our estimate satisfies $\tilde Q\geq Q$, the attempt will succeed with high probability. The set of routes used by packets constitute a shortcut with quality $\tilde O(Q)$, since for packets to have been delivered in $\tilde O(Q)$ rounds, the length of paths and their congestion on each edge must both be $\tilde O(Q)$.$\square$


**Note:** $Q$ may need to be estimated because $Q(G)$ may be lower than $Q(H)$, meaning that using topology knowledge of $H$ to route messages in $Q(H)$ rounds may be too expensive.

## Message Reduction

This message analysis motivates a simple way to reduce message complexity, following the strategy of Elkin [[Elkin '17]](https://arxiv.org/abs/1703.02411). That is, we ensure that we only ever construct shortcuts between $k=\tilde O(n/Q)$ connectible pairs.

**Theorem:** Suppose that $G'$ is a version of $G$ in which each edge is given a direction in $\{\to,\leftarrow, \perp\}$ such that $G'$ is a union of (maximal) vertex-disjoint directed paths $\{P_i\}$. Then there exists an algorithm which builds shortcuts for these paths and solves partwise aggregation on these paths using $\tilde O(Q)$ rounds and $\tilde O(m)$ messages.

*Proof:* First, we assume that a 2-approximation of $Q$, $\tilde Q$, is known. Construct a BFS tree using $O(D)$ rounds and $O(m)$ messages.

We use controlled-GHS to grow "fragments" that are subpaths with diameter $O(Q)$. Each subpath which does not span its path has size $\Omega(Q)$, so there will be $O(n/Q)$ of them. Only these incomplete subpaths enter the shortcut-assisted merging phase.

At the end of this phase, we can assume that each node $v$ knows:

1. The path ID.
2. The first node on the path.
3. The depth of $v$ in the path.

In each shortcut-assisted merging phase, we perform the following steps:

1. Flip a coin for each fragment. The leader can do this and share the result in $\tilde O(Q)$ rounds via the shortcut.
2. If a "heads" fragment has a directed edge pointing to a "tails" fragment, they decide to merge. This ensures that only pairs of nodes merge at one time and that any pair of adjacent fragments merges with probability 1/4 in each phase.
3. In order to merge the fragments, build an $\tilde O(Q)$-quality shortcut between the starts of the two fragments (these are connectable through the vertex-disjoint path). Add the shortcuts of either fragment to this new shortcut. In one phase, we are adding $O(n/Q)$ pairwise shortcuts, which increases the congestion of the existing shortcuts by $\tilde O(Q)$. The dilation of each fragment increases by a fixed quantity $\tilde O(Q)$ in each phase. Thus the dilation increases by an additive $\tilde O(Q)$ in each phase, for a maximum of $\tilde O(Q)$.

Except for shortcut construction, all steps use $\tilde O(m)$ messages. To construct the shortcuts, we are solving the pairwise problem on $O(n/Q)$ pairs, meaning this also uses $\tilde O(m)$ messages.

When $Q$ is not known, we use $O(\log n)$ phases with doubling estimates of $Q$, as before. The cost of phase $i$ is $\tilde O(2^i+D)$ rounds and $\tilde O(n+\frac{n}{2^i}\cdot 2^i+m)$ messages. Over all attempts, this is $\tilde O(Q)$ rounds and $\tilde O(m)$ messages. $\square$

**Note:** The paper [[HWZ '21]](https://arxiv.org/abs/2104.03932) uses the opposite definition of light and heavy edges. We use the more standard definition, in which the edge connecting a node to its largest subtree is "heavy" and all other edges are "light".

**Theorem:** Suppose that $G'$ is a version of $G$ in which each edge is given a direction in $\{\to,\leftarrow, \perp\}$ such that $G'$ is a union of (maximal) vertex-disjoint rooted arborescences (directed trees in which all edges point away from the root) $\{P_i\}$. Then there exists an algorithm which builds shortcuts for these trees and solves partwise aggregation using $\tilde O(Q)$ rounds and $\tilde O(m)$ messages.

*Proof:* Suppose a heavy-light edge labeling exists on a subtree. To build shortcuts, simply build shortcuts for every heavy path, then add light edges to the shortcuts. Since every node has at most $O(\log n)$ light edges on its path to the root, the shortcut for the tree has a dilation $O(\log n)$ times the maximum dilation of a path shortcut.

Now, we need to show how to grow these trees in a way that maintains an HL-labeling.

We start by growing trees up to diameter $O(Q)$ using controlled-GHS. After the iterations of controlled-GHS, the heavy-light labeling can be computed in $O(Q)$ rounds and $O(n)$ messages.

For every node $v$, we maintain the following information:

1. The tree ID of $v$, the root of the tree, and the parent of this root.
2. The subtree size of $v$.
3. The heavy-light labeling of each edge.
4. The light-depth of $v$ in the tree.

Again, fragments flip a coin and tail clusters choose to merge into a heads cluster if heads $\to$ tails. However, now, we may have many tails merging into many heads. To update property 1, we construct a cluster for each fragment and disseminate the tree ID. To update property 2, pass one message from the root of one fragment to the node in the fragment into which it merges. Then we can compute subtree-sums within the head fragment to complete this update. I need to explain fully how subtree-sums work. This isn't complicated, though. Property 3 can be computed locally, and property 4 can be computed in the same way as property 2, one light-depth at a time.

This completes the proof of the lemma.

**Theorem:** There exists a supported-CONGEST algorithm that, given a partition $\{P_i\}$ of a graph $G$, builds an $\tilde O(Q)$-congestion, $\tilde O(Q)$-dilation shortcut $\{H_i\}$ for the graph using $\tilde O(Q)$ rounds and $\tilde O(m)$ messages, where $Q$ is the shortcut quality of $G$.

The idea of this theorem is as follows: In the original algorithm, Haeupler, Wajc, and Zuzic use $O(\log n)$ phases of shortcut-assisted merging. Ultimately, they do this by adding $O(n)$ shortcut paths connecting pairs of nodes to the graph in each phase. By the previous lemma, this may use $\tilde O(nQ)$ messages. Instead, we can start by using controlled-GHS to grow fragments inside each part to radius $O(Q)$ and size $\Omega(Q)$. Then we can use their algorithm just to connect the fragment leaders. There will be $O(n/Q)$ fragment leaders (not including fragments which entirely span their part), so we will only need to add shortcuts to $O(n/Q)$ pairs in each phase, giving us an overall message complexity of $\tilde O(n/Q\cdot Q+m)=\tilde O(m)$.

*Proof:* Fix a partition. We will grow fragments for $O(\log n)$ phases until one fragment spans each part.

We start by using phases of controlled-GHS to grow fragments with diameter $O(Q)$ and size $\Omega(Q)$.

At this point, we define edge directions so that edges within each fragment point away from the root. The edges outside of a fragment are given direction $\perp$.

Then each fragment flips a coin and we use one round to determine which tails clusters are adjacent to heads clusters. For these, we add a directed edge from the heads cluster to the tails clusters, and reorient the tails clusters to conform with this new edge.

Using the previous lemma, we can merge these tails components into the heads component. Using $O(\log n)$ such phases, we can ensure that each part is spanned by one fragment and that shortcuts of quality $\tilde O(Q)$ exist for the fragment graph.

Also, every step of the algorithm except for constructing the pairwise shortcuts uses $\tilde O(m)$ messages. Constructing the shortcut for $k$ pairs uses $\tilde O(kQ)$ messages, and since we only build shortcuts for $O(n/Q)$ pairs over the course of the algorithm, this costs $\tilde O(n)$ messages.

This completes the proof that partwise aggregation can be solved using $\tilde O(Q)$ rounds and $\tilde O(m)$ messages simultaneously.

## Open Questions
- Under supported-CONGEST $KT_1$, it seems like MST is solvable in $\tilde O(Q)$ rounds and $\tilde O(n)$ messages via the method of [[KKT '15]](https://arxiv.org/abs/1502.03320). Can a similar method reduce messages with only partial topology knowledge?