---
title: "Distributed Algorithm Reference Guide"
category: tutorials
date: 2026-11-11
---

This article summarizes the state-of-the-art upper and lower bounds for various distributed computing problems. The focus is on global problems and on randomized CONGEST algorithms.

Throughout, $n$ is the number of nodes, $m$ the number of edges, $D$ the hop diameter, and $\Delta$ the maximum degree. "?" means unknown, "Unpublished" means the bound is based on an unpublished manuscript that I have seen. Bounds in different columns need not be achieved by the same algorithm.


**Table of contents**

- [Round complexity: upper and lower bounds](#round-complexity-upper-and-lower-bounds)
- [Energy complexity: CONGEST and multi-hop RADIO](#energy-complexity-congest-and-multi-hop-radio)
- [Source table 3: general, planar, and clique graphs](#source-table-3-general-planar-and-clique-graphs)
- [Local problems: randomized versus deterministic CONGEST](#local-problems-randomized-versus-deterministic-congest)
  - [Global problems with matching bounds](#global-problems-with-matching-deterministic-and-randomized-bounds)
  - [Global problems with remaining gaps](#global-problems-with-remaining-randomizeddeterministic-gaps)

## Round complexity: upper and lower bounds

<table class="bordered-table">
<thead>
<tr>
<th scope="col" markdown="span">Problem</th>
<th scope="col" markdown="span">Upper bound (rounds)</th>
<th scope="col" markdown="span">Lower bound (rounds)</th>
</tr>
</thead>
<tbody>
<tr><th class="table-section" colspan="3" markdown="span">Local problems — randomized CONGEST</th></tr>
<tr>
<td markdown="span">MIS</td>
<td markdown="span">$O(\log\Delta+\log^3\log n)$ [[Gha '16]](https://arxiv.org/abs/1506.05093), [[GK '21]](https://arxiv.org/abs/2011.04511)</td>
<td markdown="span">$\Omega\!\left(\frac{\log n}{\log\log n}\right)$ [[KS '26]](https://arxiv.org/abs/2610.18215)<br>$\Omega\!\left(\log^*n+\min\left\{\Delta,\frac{\log\log n}{\log\log\log n}\right\}+\min\left\{\log\Delta,\sqrt{\log n}\right\}\right)$ [[Naor '91]](https://doi.org/10.1137/0404036), [[BBHORS '19]](https://arxiv.org/abs/1901.02441), [[KS '25]](https://arxiv.org/abs/2505.15654)</td>
</tr>
<tr>
<td markdown="span">Maximal matching</td>
<td markdown="span">$O\!\left(\min\left\{\Delta+\log^*n,\log\Delta+\log^3\log n\right\}\right)$ [[BEPS '16]](https://arxiv.org/abs/1202.1983), [[Fis '17]](https://arxiv.org/abs/1703.00900), [[BEG '18]](https://arxiv.org/abs/1712.00285)</td>
<td markdown="span">$\Omega\!\left(\log^*n+\min\left\{\Delta,\frac{\log\log n}{\log\log\log n}\right\}+\min\left\{\log\Delta,\sqrt{\log n}\right\}\right)$ [[Naor '91]](https://doi.org/10.1137/0404036), [[BBHORS '19]](https://arxiv.org/abs/1901.02441), [[KS '25]](https://arxiv.org/abs/2505.15654)</td>
</tr>
<tr>
<td markdown="span">$\Delta+1$ vertex coloring</td>
<td markdown="span">$O\!\left(\min\left\{\Delta+\log^*n,\log^3\log n\right\}\right)$ [[BE '09]](https://www.cs.bgu.ac.il/~elkinm/fp136-barenboim.pdf), [[HNT '21]](https://arxiv.org/abs/2105.04700)<br>$O(\log^*n)$ when $\Delta\geq\log^{2+\varepsilon}n$ [[HNT '21]](https://arxiv.org/abs/2105.04700)</td>
<td markdown="span">$\Omega(\log^*n)$ [[Naor '91]](https://doi.org/10.1137/0404036)</td>
</tr>
<tr>
<td markdown="span">$\Delta+1$ edge coloring</td>
<td markdown="span">$\tilde O(\operatorname{poly}(\Delta)\log^5n)$ [[BNN '26]](https://arxiv.org/abs/2608.19184)</td>
<td markdown="span">$\Omega\!\left(\frac{\log\log n}{\log\Delta}\right)$ [[CHLPU '18]](https://arxiv.org/abs/1708.04290)</td>
</tr>
<tr>
<td markdown="span">$\Delta^2$ edge coloring</td>
<td markdown="span">$O\!\left(\min\left\{\Delta+\log^*n,\log^4\log n\right\}\right)$ [[BEG '18]](https://arxiv.org/abs/1712.00285), [[HN '21]](https://arxiv.org/abs/2102.04546)<br>$O(\log^*\Delta)$ when $\Delta\geq\log^{1+\frac{1}{\log^*n}}n$ [[HN '21]](https://arxiv.org/abs/2102.04546)</td>
<td markdown="span">$\Omega(\log^*n)$ [[Naor '91]](https://doi.org/10.1137/0404036)</td>
</tr>
<tr>
<td markdown="span">$(2+\varepsilon)$-approximation minimum vertex cover</td>
<td markdown="span">$O\!\left(\frac{\log\Delta}{\log\log\Delta}\right)$ [[BCS '16]](https://arxiv.org/abs/1602.03713)</td>
<td markdown="span">$\Omega\!\left(\min\left\{\frac{\log\Delta}{\log\log\Delta},\sqrt{\frac{\log n}{\log\log n}}\right\}\right)$ [[KMW '16]](https://arxiv.org/abs/1011.5470), [[CL '21]](https://arxiv.org/abs/2002.06005)</td>
</tr>
<tr>
<td markdown="span">$(1+\varepsilon)$-approximation maximum cardinality matching</td>
<td markdown="span">$O\!\left(\frac{\log\Delta}{\log\log\Delta}\right)$ [[BCGS '17]](https://arxiv.org/abs/1708.00276)</td>
<td markdown="span">$\Omega\!\left(\min\left\{\frac{\log\Delta}{\log\log\Delta},\sqrt{\frac{\log n}{\log\log n}}\right\}\right)$ [[KMW '16]](https://arxiv.org/abs/1011.5470), [[CL '21]](https://arxiv.org/abs/2002.06005)</td>
</tr>
<tr>
<td markdown="span">Triangle listing</td>
<td markdown="span">$\tilde O(n^{1/3})$ [[CS '19]](https://arxiv.org/abs/1904.08037)</td>
<td markdown="span">$\tilde\Omega(n^{1/3})$ [[ILG '17]](https://arxiv.org/abs/1705.09061), [[PRS '18]](https://arxiv.org/abs/1602.08481)</td>
</tr>
<tr><th class="table-section" colspan="3" markdown="span">Global problems with medium congestion ($\tilde\Omega(D)\cap\tilde o(n)$ rounds)</th></tr>
<tr>
<td markdown="span">BFS tree, leader election</td>
<td markdown="span">$O(D)$</td>
<td markdown="span">$\Omega(D)$</td>
</tr>
<!-- <tr>
<td markdown="span">DFS tree</td>
<td markdown="span">$\tilde O(n^{3/4}+\sqrt{Dn})$ [[GP '17]](https://groups.csail.mit.edu/tds/papers/Parter/disc17-mohsen.pdf)<br>$\tilde O(n^{2/3}+\sqrt{Dn})$ [unpublished]</td>
<td markdown="span">$\tilde \Omega(D+\sqrt{n})$ [unpublished]</td>
</tr> -->
<tr>
<td markdown="span">SSSP</td>
<td markdown="span">$\tilde O(D+\sqrt{n}+n^{2/5+o(1)}D^{2/5})$ [[CF '23]](https://nairenc.github.io/nairenc_files/parallelexactsspsqrt.pdf)</td>
<td markdown="span">$\tilde\Omega(D+\sqrt{n})$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049)</td>
</tr>
<tr>
<td markdown="span">$(1+\varepsilon)$-SSSP</td>
<td markdown="span">$\tilde O(\varepsilon^{-1}(D+\sqrt{n}))$ [[BKKL '16b]](https://arxiv.org/abs/1607.05127) [[GKZ '25]](https://arxiv.org/abs/2511.06581)</td>
<td markdown="span">$\tilde\Omega(D+\sqrt{n})$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049)</td>
</tr>
<tr>
<td markdown="span">MST</td>
<td markdown="span">$\tilde O(D+\sqrt{n})$ [[KP '98]](https://courses.csail.mit.edu/6.852/15/papers/KuttenPeleg.pdf)</td>
<td markdown="span">$\tilde\Omega(D+\sqrt{n})$ [[PR '00]](https://www.cs.bgu.ac.il/~elkinm/teaching/distr_comp/autumn16/peleg_rub.pdf)</td>
</tr>
<tr>
<td markdown="span">Minimum cut</td>
<td markdown="span">$\tilde O(D+\sqrt{n})$ [[DEMN '21]](https://arxiv.org/abs/2004.09129)</td>
<td markdown="span">$\tilde\Omega(D+\sqrt{n})$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049)</td>
</tr>
<tr>
<td markdown="span">Maximum flow</td>
<td markdown="span">$n^{1/2+o(1)}(D+\sqrt{n})$ [[de Vos '23]](https://arxiv.org/abs/2304.01600)</td>
<td markdown="span">$\tilde\Omega(D+\sqrt{n})$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049)</td>
</tr>
<tr>
<td markdown="span">$(1+\varepsilon)$-maximum flow</td>
<td markdown="span">$\tilde O((D+\sqrt{n})n^{o(1)}\varepsilon^{-3})$ [[GKKLP '15]](https://arxiv.org/abs/1508.04747)</td>
<td markdown="span">$\tilde\Omega(D+\sqrt{n})$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049)</td>
</tr>
<tr>
<td markdown="span">Minimum-cost maximum flow</td>
<td markdown="span">$\tilde O((D+\sqrt{n})n^{1/2+o(1)})$ [[de Vos '23]](https://arxiv.org/abs/2304.01600)</td>
<td markdown="span">$\tilde\Omega(D+\sqrt{n})$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049)</td>
</tr>
<tr>
<td markdown="span">$(1+\varepsilon)$-MCMF</td>
<td markdown="span">?</td>
<td markdown="span">$\tilde\Omega(D+\sqrt{n})$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049)</td>
</tr>
<tr>
<td markdown="span">$\varepsilon$-Laplacian</td>
<td markdown="span">$O((D+\sqrt{n})n^{o(1)}\log(\varepsilon^{-1}))$ [[FGLPSY '22]](https://arxiv.org/abs/2012.15675)</td>
<td markdown="span">$\tilde\Omega(D+\sqrt{n})$ [[FGLPSY '22]](https://arxiv.org/abs/2012.15675)</td>
</tr>
<tr><th class="table-section" colspan="3" markdown="span">Global problems with high congestion ($\Omega(n)$ rounds)</th></tr>
<tr>
<td markdown="span">Diameter</td>
<td markdown="span">$\tilde O(n)$ [PRT '12 ?]</td>
<td markdown="span">$\tilde\Omega(n)$ [[FHW '12]](https://citeseerx.ist.psu.edu/document?doi=f8086e9a4637a60405559d731500a980060c3cb7&repid=rep1&type=pdf)</td>
</tr>
<tr>
<td markdown="span">Unweighted APSP</td>
<td markdown="span">$O(n/\log n)$</td>
<td markdown="span">$\Omega(n/\log n)$</td>
</tr>
<tr>
<td markdown="span">APSP</td>
<td markdown="span">$\tilde O(n)$ [[HFQALSJ '16]](https://qiangshenghua.github.io/papers/spaa16.pdf)</td>
<td markdown="span">$\tilde\Omega(n)$ [[FHW '12]](https://citeseerx.ist.psu.edu/document?doi=f8086e9a4637a60405559d731500a980060c3cb7&repid=rep1&type=pdf) [[CKP '17]](https://arxiv.org/abs/1705.05646)</td>
</tr>
<tr>
<td markdown="span">Minimum-weight cycle (MWCycle)</td>
<td markdown="span">$\tilde O(n)$ [[BN '19]](https://arxiv.org/abs/1811.03337)</td>
<td markdown="span">$\tilde\Omega(D+\sqrt{m}+n^{2/3})$ [[MR '24]](https://www.cs.utexas.edu/~vlr/papers/podc2024-proc.pdf) [[CCDJMNY '26]](https://arxiv.org/abs/2603.25368) [unpublished]</td>
</tr>
<tr>
<td markdown="span">All-pairs minimum cut (APMC)</td>
<td markdown="span">$\tilde O(n^{3/2+o(1)})$ [unpublished]</td>
<td markdown="span">$\tilde \Omega(n)$ [unpublished]</td>
</tr>
<!-- <tr>
<td markdown="span">Unweighted APMC</td>
<td markdown="span">$\tilde O(n)$ [unpublished]</td>
<td markdown="span">$\tilde \Omega(n)$ [unpublished]</td>
</tr> -->
<tr>
<td markdown="span">$(1+\varepsilon)$-APMC</td>
<td markdown="span">$\tilde O(n)$ [[KX '16]](https://arxiv.org/abs/1402.3851)</td>
<td markdown="span">?</td>
</tr>
<tr><th class="table-section" colspan="3" markdown="span">Global problems with very high congestion ($\Omega(n^2)$ rounds)</th></tr>
<tr>
<td markdown="span">Min vertex cover, max independent set, min vertex coloring</td>
<td markdown="span">$\tilde O(n^2)$ [trivial]</td>
<td markdown="span">$\tilde\Omega(n^2)$ [[CKP '17]](https://arxiv.org/abs/1705.05646)</td>
</tr>
<tr>
<td markdown="span">Minimum dominating set</td>
<td markdown="span">$\tilde O(n^2)$ </td>
<td markdown="span">$\tilde\Omega(n^2)$ </td>
</tr>
</tbody>
</table>

<!-- ## Energy complexity: CONGEST and multi-hop RADIO

Energy is the maximum number of awake rounds per node.

| Problem | CONGEST awake complexity | Multi-hop RADIO awake complexity |
| --- | --- | --- |
| Maximal matching | - | $O(\log n\log\Delta)$ [[DGHP '23]](https://arxiv.org/abs/2104.09096) |
| Broadcast | $\Theta(\log n)$ [[CDHHLP '18]](https://arxiv.org/abs/1710.01800) [[BM '21]](https://arxiv.org/abs/2108.01963) | $\Omega(\log n)$–$O(\log n\log\Delta)$ [[CDHHLP '18]](https://arxiv.org/abs/1710.01800) |
| Leader election | $\Omega(\log n)$ - $O(\log n)$ [[BM '21]](https://arxiv.org/abs/2108.01963) | - |
| Minimum cut | $\Omega(\log n)$–$O(\log^7n)$ [unpublished] | $\tilde\Theta(n)$ [[Chang '23]](https://arxiv.org/abs/1805.04071) |
| BFS | $O(\log^7n)$ [[DH '22]](https://arxiv.org/abs/2205.12830) | $O(\log^9n)$ [[DH '22]](https://arxiv.org/abs/2205.12830) |
| SSSP | $\Omega(\log n)$ [[CDHHLP '18]](https://arxiv.org/abs/1710.01800)<br>$O(\log^{26}n)$ [[GT '24]](https://arxiv.org/abs/2409.15470) | - |
| MST | $\Theta(\log n)$ [[AMP '24]](https://arxiv.org/abs/2204.08385) | $\Omega(\log n)$–? [[AMP '24]](https://arxiv.org/abs/2204.08385) |
| Diameter | $\tilde\Theta(n)$ [[DPR '26]](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.DISC.2026.13) | $\tilde\Theta(n)$ [[Chang '23]](https://arxiv.org/abs/1805.04071) |
{: .bordered-table}

## Source table 3: general, planar, and clique graphs

"General," "Planar," and "Clique" give round complexity. The two energy columns apply to general and planar graphs, respectively.

| Problem | General rounds | General energy | Planar rounds | Planar energy | Clique rounds |
| --- | --- | --- | --- | --- | --- |
| BFS | $\Theta(D)$ | $O(\log^3n)$ | $\Theta(D)$ | $O(\log^3n)$ | $O(1)$ (trivial) |
| MST | $\tilde\Theta(D+\sqrt n)$ | $\Theta(\log n)$ | $\tilde\Theta(D)$ [[GH '16]](https://groups.csail.mit.edu/tds/papers/Ghaffari/soda16-planar2.pdf) | $\Theta(\log n)$ | $\Theta(1)$ [[JN '18]](https://arxiv.org/abs/1707.08484) |
| Minimum cut | $\tilde\Theta(D+\sqrt n)$ | $O(\log^7n)$ | $\tilde\Theta(D)$ [[GZ '22]](https://arxiv.org/abs/2205.14967) | $O(\log^7n)$ | $O(\log^2n)$ [[GN '18]](https://folia.unifr.ch/global/documents/202934) |
| Approximate minimum cut | $\tilde\Theta(D+\sqrt n)$ | $O(\varepsilon^{-5}\log^4n)$ | $\tilde\Theta(D)$ | $O(\varepsilon^{-5}\log^4n)$ | $\Theta(1)$ [[GN '18]](https://folia.unifr.ch/global/documents/202934) |
| Simple minimum cut | $\tilde\Theta(D+\sqrt n)$ | $O(\log^7n)$ | $\tilde\Theta(D)$ | $O(\log^2n)$ | $O(\log^2n)$ [[GN '18]](https://folia.unifr.ch/global/documents/202934) |
| DFS | $\Omega(D)$–$O(n)$ | — | $\tilde\Theta(D)$ | — | $\Theta(1)$ (trivial) |
| Minimum-weight cycle | $\tilde\Theta(n)$ | $\tilde\Theta(n)$ | $\tilde\Theta(D)$ | — | — |
| Girth | — | — | — | — | $\tilde O(n^{0.158})$ [[CKKLPS '15]](https://arxiv.org/abs/1503.04963) |
| SSSP | $\tilde O(\sqrt n+D+n^{2/5+o(1)}D^{2/5})$ | $O(\log^{26}n)$ | — | $O(\log^{26}n)$ | $\tilde O(n^{1/6})$ [[CDKL '19]](https://arxiv.org/abs/1903.05956) |
| Approximate SSSP | $\tilde O(D+\sqrt n)$ [[BKKL '16b]](https://arxiv.org/abs/1607.05127) | $O(\log^{26}n)$ | $\tilde O(D)$ [[RGHZL '22]](https://arxiv.org/abs/2204.05874) | $O(\log^{23}n)$ | $\operatorname{polylog}(n)$ [[BFKL '16a]](https://arxiv.org/abs/1607.05127) |
| APSP | — | $\tilde\Theta(n)$ | — | — | $\tilde O(n^{0.158})$ [[CKKLPS '15]](https://arxiv.org/abs/1503.04963) |
| Approximate APSP | — | — | — | — | $\tilde O(n^{0.158})$ [[CKKLPS '15]](https://arxiv.org/abs/1503.04963) |
| $O(1)$-approximate APSP | — | — | — | — | $\Theta(1)$ [[BCCDL '24]](https://arxiv.org/abs/2405.02695) |
| Maximum flow | $m^{3/7+o(1)}(D+\sqrt n D^{1/4})$ | — | $\tilde O(D^2)$ | — | $O(\sqrt n)$ [[FdV '22]](https://arxiv.org/abs/2205.12059) |
| Approximate maximum flow | $(D+\sqrt n)n^{o(1)}$ | — | $\tilde O(D^2)$ | — | $O(\sqrt n)$ [[FdV '22]](https://arxiv.org/abs/2205.12059) |
| Approximate Laplacian | — | — | — | — | $\tilde O(\sqrt n)$ [[FdV '22]](https://arxiv.org/abs/2205.12059) |
| Minimum-cost maximum flow | — | — | — | — | $\tilde O(\sqrt n)$ [[FdV '22]](https://arxiv.org/abs/2205.12059) |
| Matrix multiplication | — | — | — | — | $\tilde O(n^{0.158})$ [[CKKLPS '15]](https://arxiv.org/abs/1503.04963) |
| Triangle counting | — | — | — | — | $\tilde O(n^{0.158})$ [[CKKLPS '15]](https://arxiv.org/abs/1503.04963) |
| Trivial upper bound | $O(m)$ | $O(m)$ | $O(n)$ | ? | $O(n)$ |
{: .bordered-table} -->

<!-- ## Local problems: randomized versus deterministic CONGEST


<table class="bordered-table">
<thead>
<tr><th rowspan="2" markdown="span">Problem</th><th colspan="2">Randomized</th><th colspan="2">Deterministic</th></tr>
<tr><th>Upper bound</th><th>Lower bound</th><th>Upper bound</th><th>Lower bound</th></tr>
</thead>
<tbody>
<tr>
<td markdown="span">MIS</td>
<td markdown="span">$O(\log\Delta+\log^3\log n)$ [[Gha '16]](https://arxiv.org/abs/1506.05093), [[GK '21]](https://arxiv.org/abs/2011.04511)</td>
<td markdown="span">$\Omega\!\left(\frac{\log n}{\log\log n}\right)$ [[KS '26]](https://arxiv.org/abs/2610.18215)<br>$\Omega\!\left(\log^*n+\min\left\{\Delta,\frac{\log\log n}{\log\log\log n}\right\}+\min\left\{\log\Delta,\sqrt{\log n}\right\}\right)$ [[Naor '91]](https://doi.org/10.1137/0404036), [[BBHORS '19]](https://arxiv.org/abs/1901.02441), [[KS '25]](https://arxiv.org/abs/2505.15654)</td>
<td markdown="span">$O\!\left(\min\left\{\Delta+\log^*n,\log^2\Delta\,\log\log\Delta\,\log n\right\}\right)$ [[BE '09]](https://www.cs.bgu.ac.il/~elkinm/fp136-barenboim.pdf), [[FGGKR '23]](https://arxiv.org/abs/2209.11651)</td>
<td markdown="span">$\Omega\!\left(\log^*n+\min\left\{\Delta,\frac{\log n}{\log\log n}\right\}\right)$ [[Lin '92]](https://courses.csail.mit.edu/6.852/08/papers/Linial.pdf), [[BBHORS '19]](https://arxiv.org/abs/1901.02441)</td>
</tr>
<tr>
<td markdown="span">Maximal matching</td>
<td markdown="span">$O\!\left(\min\left\{\Delta+\log^*n,\log\Delta+\log^3\log n\right\}\right)$ [[BEPS '16]](https://arxiv.org/abs/1202.1983), [[Fis '17]](https://arxiv.org/abs/1703.00900), [[BEG '18]](https://arxiv.org/abs/1712.00285)</td>
<td markdown="span">$\Omega\!\left(\log^*n+\min\left\{\Delta,\frac{\log\log n}{\log\log\log n}\right\}+\min\left\{\log\Delta,\sqrt{\log n}\right\}\right)$ [[Naor '91]](https://doi.org/10.1137/0404036), [[BBHORS '19]](https://arxiv.org/abs/1901.02441), [[KS '25]](https://arxiv.org/abs/2505.15654)</td>
<td markdown="span">$O\!\left(\min\left\{\Delta+\log^*n,\log^2\Delta\,\log n\right\}\right)$ [[BEG '18]](https://arxiv.org/abs/1712.00285), [[Fis '17]](https://arxiv.org/abs/1703.00900)</td>
<td markdown="span">$\Omega\!\left(\log^*n+\min\left\{\Delta,\frac{\log n}{\log\log n}\right\}\right)$ [[Lin '92]](https://courses.csail.mit.edu/6.852/08/papers/Linial.pdf), [[BBHORS '19]](https://arxiv.org/abs/1901.02441)</td>
</tr>
<tr>
<td markdown="span">$\Delta+1$ vertex coloring</td>
<td markdown="span">$O\!\left(\min\left\{\Delta+\log^*n,\log^3\log n\right\}\right)$ [[BE '09]](https://www.cs.bgu.ac.il/~elkinm/fp136-barenboim.pdf), [[HNT '21]](https://arxiv.org/abs/2105.04700)<br>$O(\log^*n)$ when $\Delta\geq\log^{2+\varepsilon}n$ [[HNT '21]](https://arxiv.org/abs/2105.04700)</td>
<td markdown="span">$\Omega(\log^*n)$ [[Naor '91]](https://doi.org/10.1137/0404036)</td>
<td markdown="span">$O\!\left(\min\left\{\Delta+\log^*n,\log^2\Delta\,\log n\right\}\right)$ [[BE '09]](https://www.cs.bgu.ac.il/~elkinm/fp136-barenboim.pdf), [[GK '21]](https://arxiv.org/abs/2011.04511)</td>
<td markdown="span">$\Omega(\log^*n)$ [[Lin '92]](https://courses.csail.mit.edu/6.852/08/papers/Linial.pdf)</td>
</tr>
<tr>
<td markdown="span">$\Delta+1$ edge coloring</td>
<td markdown="span">$\tilde O(\operatorname{poly}(\Delta)\log^5n)$ [[BNN '26]](https://arxiv.org/abs/2608.19184)</td>
<td markdown="span">$\Omega\!\left(\frac{\log\log n}{\log\Delta}\right)$ [[CHLPU '18]](https://arxiv.org/abs/1708.04290)</td>
<td markdown="span">$\tilde O(\operatorname{poly}(\Delta)\log^5n)$ [[BNN '26]](https://arxiv.org/abs/2608.19184)</td>
<td markdown="span">$\Omega\!\left(\frac{\log n}{\log\Delta}\right)$ [[CHLPU '18]](https://arxiv.org/abs/1708.04290)</td>
</tr>
<tr>
<td markdown="span">$\Delta^2$ edge coloring</td>
<td markdown="span">$O\!\left(\min\left\{\Delta+\log^*n,\log^4\log n\right\}\right)$ [[BEG '18]](https://arxiv.org/abs/1712.00285), [[HN '21]](https://arxiv.org/abs/2102.04546)<br>$O(\log^*\Delta)$ when $\Delta\geq\log^{1+\frac{1}{\log^*n}}n$ [[HN '21]](https://arxiv.org/abs/2102.04546)</td>
<td markdown="span">$\Omega(\log^*n)$ [[Naor '91]](https://doi.org/10.1137/0404036)</td>
<td markdown="span">$O(\Delta+\log^*n)$ [[BEG '18]](https://arxiv.org/abs/1712.00285)</td>
<td markdown="span">$\Omega(\log^*n)$ [[Lin '92]](https://courses.csail.mit.edu/6.852/08/papers/Linial.pdf)</td>
</tr>
<tr>
<td markdown="span">$(2+\varepsilon)$-approximation minimum vertex cover</td>
<td markdown="span">$O\!\left(\frac{\log\Delta}{\log\log\Delta}\right)$ [[BCS '16]](https://arxiv.org/abs/1602.03713)</td>
<td markdown="span">$\Omega\!\left(\min\left\{\frac{\log\Delta}{\log\log\Delta},\sqrt{\frac{\log n}{\log\log n}}\right\}\right)$ [[KMW '16]](https://arxiv.org/abs/1011.5470), [[CL '21]](https://arxiv.org/abs/2002.06005)</td>
<td markdown="span">$O\!\left(\frac{\log\Delta}{\log\log\Delta}\right)$ [[BCS '16]](https://arxiv.org/abs/1602.03713)</td>
<td markdown="span">$\Omega\!\left(\min\left\{\frac{\log\Delta}{\log\log\Delta},\sqrt{\frac{\log n}{\log\log n}}\right\}\right)$ [[KMW '16]](https://arxiv.org/abs/1011.5470), [[CL '21]](https://arxiv.org/abs/2002.06005)</td>
</tr>
<tr>
<td markdown="span">$(1+\varepsilon)$-approximation maximum cardinality matching</td>
<td markdown="span">$O\!\left(\frac{\log\Delta}{\log\log\Delta}\right)$ [[BCGS '17]](https://arxiv.org/abs/1708.00276)</td>
<td markdown="span">$\Omega\!\left(\min\left\{\frac{\log\Delta}{\log\log\Delta},\sqrt{\frac{\log n}{\log\log n}}\right\}\right)$ [[KMW '16]](https://arxiv.org/abs/1011.5470), [[CL '21]](https://arxiv.org/abs/2002.06005)</td>
<td markdown="span">$\operatorname{polylog}(n)$ for fixed $\varepsilon$ [[FMU '22]](https://doi.org/10.1145/3519935.3520039)</td>
<td markdown="span">$\Omega\!\left(\min\left\{\frac{\log\Delta}{\log\log\Delta},\sqrt{\frac{\log n}{\log\log n}}\right\}\right)$ [[KMW '16]](https://arxiv.org/abs/1011.5470), [[CL '21]](https://arxiv.org/abs/2002.06005)</td>
</tr>
<tr>
<td markdown="span">Triangle listing</td>
<td markdown="span">$\tilde O(n^{1/3})$ [[CS '19]](https://arxiv.org/abs/1904.08037)</td>
<td markdown="span">$\tilde\Omega(n^{1/3})$ [[ILG '17]](https://arxiv.org/abs/1705.09061), [[PRS '18]](https://arxiv.org/abs/1602.08481)</td>
<td markdown="span">$n^{1/3+o(1)}$ [[CLV '22]](https://arxiv.org/abs/2205.09245)</td>
<td markdown="span">$\tilde\Omega(n^{1/3})$ [[ILG '17]](https://arxiv.org/abs/1705.09061), [[PRS '18]](https://arxiv.org/abs/1602.08481)</td>
</tr>
</tbody>
</table> -->

<!-- ### Global problems with nearly matching deterministic and randomized bounds



- **Broadcast, BFS, leader election, and basic tree aggregates:** $\Theta(D)$ rounds using flooding, BFS, and convergecast; these algorithms are deterministic.
- **MST:** $\tilde\Theta(D+\sqrt n)$; the upper bound is deterministic [[KP '98]](https://courses.csail.mit.edu/6.852/15/papers/KuttenPeleg.pdf), matching the randomized lower bound [[PR '00]](https://www.cs.bgu.ac.il/~elkinm/teaching/distr_comp/autumn16/peleg_rub.pdf).
- **$(1+\varepsilon)$-SSSP and transshipment:** deterministic $\tilde O(\varepsilon^{-1}(D+\sqrt n))$ [[GKZ '25]](https://arxiv.org/abs/2511.06581), matching the randomized round bound and the $\tilde\Omega(D+\sqrt n)$ lower bound for fixed $\varepsilon$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049).
- **Exact unweighted APSP and unweighted diameter:** deterministic $O(n)$ via pipelined BFS from all sources; near-linear randomized lower bounds leave at most logarithmic factors. See the independent algorithms of [[HW '12]](https://tik-db.ee.ethz.ch/file/3addb87bcaf363395932dcb5773771e6/) and [PRT '12 ?].
- **Exact minimum vertex cover, maximum independent set, and minimum vertex coloring:** deterministic topology gathering takes $O(m)\subseteq O(n^2)$ rounds, matching worst-case randomized $\tilde\Omega(n^2)$ lower bounds [[CKP '17]](https://arxiv.org/abs/1705.05646). Local computation is unrestricted. -->

<!-- ### Global problems with remaining randomized/deterministic gaps


| Problem | Randomized upper bound | Deterministic upper bound |
| --- | --- | --- |
| Exact SSSP | $\tilde O(D+\sqrt n+n^{2/5+o(1)}D^{2/5})$ [[CF '23]](https://nairenc.github.io/nairenc_files/parallelexactsspsqrt.pdf) | $O(n)$ |
| Weighted APSP | $\tilde O(n)$ [[BN '19]](https://arxiv.org/abs/1811.03337) | $\tilde O(n^{4/3})$ [[AR '20]](https://arxiv.org/abs/2005.09588) |
| Exact minimum cut | $\tilde O(D+\sqrt n)$ [[DEMN '21]](https://arxiv.org/abs/2004.09129) | $\tilde O(\lambda^4(D+\sqrt n))$ [[NS '14]](https://arxiv.org/abs/1408.0557) |
| DFS | $\tilde O(n^{3/4}+\sqrt{Dn})$ [[GP '17]](https://groups.csail.mit.edu/tds/papers/Parter/disc17-mohsen.pdf) | $O(n)$ |
| Exact maximum flow / MCMF | $n^{1/2+o(1)}(D+\sqrt n)$ [[de Vos '23]](https://arxiv.org/abs/2304.01600) | - |
| $(1+\varepsilon)$-maximum flow | $(D+\sqrt n)n^{o(1)}\varepsilon^{-3}$ [[GKKLP '15]](https://arxiv.org/abs/1508.04747) | - |
| $\varepsilon$-Laplacian solving | $(D+\sqrt n)n^{o(1)}\log(\varepsilon^{-1})$ [[FGLPSY '21]](https://arxiv.org/abs/2012.15675) | - |
{: .bordered-table} -->




