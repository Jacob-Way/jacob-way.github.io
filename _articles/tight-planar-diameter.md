---
title: "Near-Optimal Planar Diameter [AI Result]"

category: results
published: true
# status: soon
date: 2026-11-15
---

## The Algorithm

## The Lower Bound
For the lower bound, we will construct a planar graph with $n$ nodes and diameter $\sqrt{n}$ for which diameter computation solves an $\Theta(n)$-bit distributed set disjointness problem across a small cut. This means that there is no constant-probability diameter algorithm for planar graphs with $O(D^{2-\epsilon})$ round complexity, for any constant $\epsilon>0$.

**The Base Graph:** Let $k$ be an arbitrary integer. We start by constructing two $k\times k$ grids of nodes, where each node is connected by an edge to the adjacent nodes. $A=\{a_{i,j}:i,j\in [k]\}$ is the set of nodes in one grid, and $B=\{b_{i,j}\}$ is the set of nodes in the other. Add the following additional edges: $(a_{0,0},b_{k,k}),(a_{0,k},b_{k,0}),(a_{k,0},b_{0,k}),(a_{k,k},b_{0,0})$.

**Claim:** The node $a_{i,j}$ is farthest from $b_{i,j}$ in the base graph.

*Proof:* To reach $b_{\kappa,\ell}$ from $a_{i,j}$, we need to first reach one of the 4 crossing edges, then cross, then go to $b_{\kappa,\ell}$. Suppose we use crossing edge $(a_{\mu,\nu},b_{\nu,\mu})$. The cost will be $1+\min_{\text{crossing edges }(\mu,\nu)}\abs{i-\mu}+\abs{j-\nu}+\abs{\kappa-(k-\mu)}+\abs{\ell-(k-\nu)}$ hops. We can minimize over $\mu$ and $\nu$ independently to compute this minimum. The result is $1+2k-\abs{i-\kappa}-\abs{j-\ell}$. $\square$

**The Lower Bound Graph:** Alice and Bob compute $k\times k$-bit messages: $\alpha,\beta\in \{0,1\}^{k^2}$. For each $i,j\in [k]$, if $\alpha_{i,j}=0$, add two auxiliary nodes connected directly to $a_{i,j}$. If $\alpha_{i,j}=1$, add two auxiliary nodes in a path to $a_{i,j}$. This change increases the diameter of the base graph since the auxiliary nodes of $a_{i,j}$ are further from the auxiliary nodes of $b_{i,j}$. If both Alice and Bob have all zeros, the diameter of $G$ will be $2k+3$. If they have disjoint messages, the diameter of $G$ will be $2k+4$. If their messages share a bit, the diameter of $G$ will be $2k+5$. Therefore computing diameter exactly is enough to determine the disjointness of the two $k^2$-bit messages. Taking $k=\Theta(\sqrt{n})$, $\Omega(n/\log n)$ messages must cross a cut of size $4$, meaning $\Omega(n/\log n)$ is a lower-bound on round complexity.

## Open Questions:
- By extending the crossing edges to form paths of length $k$, we can show that that $\tilde \Omega(D^3)$ is a message complexity lower-bound for solving this problem in polynomial time whenever $D=O(\sqrt{n})$. This is $\omega(n)$ whenever $D=\omega(n^{1/3})$. Is this tight? What is the message complexity of this problem? In general graphs, one can prove a message lower bound of $\tilde \Omega(\min\{Dm,n^2\})$, and a round-message tradeoff (by combining the strategies from [[DPPPR '23]](https://arxiv.org/abs/2311.14811) and [[ACK '16]](https://arxiv.org/abs/1605.05109)).
- Together with the other recent results for planar graphs ([[LTY '26]](https://arxiv.org/abs/2606.31192v2), [[ADW '26]](https://arxiv.org/abs/2608.09500) , and [[Senge '26]](https://arxiv.org/abs/2611.02256)), this seems to complete the complexity landscape for planar graphs - every problem has complexity $\hat \Theta(D)$ except for diameter computation, which has complexity $\tilde \Theta(D^2)$. Are there other complexity classes for planar graphs?

## AI Use
Both the upper and lower bound discussed in this article were discovered by [ChatGPT-6 Astra](https://chatgpt.com/share/6af9bf8a-b488-83ea-b1bb-859944c6c6b5). I wrote the article based on my own understanding of the result.