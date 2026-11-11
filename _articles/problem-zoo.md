---
title: "Distributed Algorithm Reference Guide"
category: tutorials
date: 2026-11-11
---

This article summarizes the state-of-the-art upper and lower bounds for various distributed computing problems. The focus is on global problems and on randomized CONGEST algorithms.

Throughout, $n$ is the number of nodes, $m$ the number of edges, $D$ the hop diameter, and $\Delta$ the maximum degree. "?" means unknown, "Unpublished" means the bound is based on an unpublished manuscript that I have seen. Bounds in different columns need not be achieved by the same algorithm.


**Table of contents**

- [Round complexity: upper and lower bounds](#round-complexity-upper-and-lower-bounds)
- [Source table 1: rounds, messages, and energy](#source-table-1-rounds-messages-and-energy)
  - [Boxed procedure: collecting the entire graph](#boxed-procedure-collecting-the-entire-graph)
  - [Boxed procedure: a naive energy bound in LOCAL](#boxed-procedure-a-naive-energy-bound-in-local)
- [Source table 2: energy in LOCAL, CONGEST, and multi-hop RADIO](#source-table-2-energy-in-local-congest-and-multi-hop-radio)
- [Source table 3: general, planar, and clique graphs](#source-table-3-general-planar-and-clique-graphs)
- [Source table 4: randomized versus deterministic CONGEST (incomplete)](#source-table-4-randomized-versus-deterministic-congest-incomplete)
- [Source table 5: sparsifiers](#source-table-5-sparsifiers)
- [Reference notes](#reference-notes)

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
<tr>
<td markdown="span">DFS tree</td>
<td markdown="span">$\tilde O(n^{3/4}+\sqrt{Dn})$ [[GP '17]](https://groups.csail.mit.edu/tds/papers/Parter/disc17-mohsen.pdf)<br>$\tilde O(n^{2/3}+\sqrt{Dn})$ [unpublished]</td>
<td markdown="span">$\tilde \Omega(D+\sqrt{n})$ [unpublished]</td>
</tr>
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
<td markdown="span">$O(n/\log n)$ [uncertain]</td>
<td markdown="span">$\Omega(n/\log n)$ [uncertain]</td>
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
<tr>
<td markdown="span">Unweighted APMC</td>
<td markdown="span">$\tilde O(n)$ [unpublished]</td>
<td markdown="span">$\tilde \Omega(n)$ [unpublished]</td>
</tr>
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
<td markdown="span">$\tilde O(n^2)$ [uncertain]</td>
<td markdown="span">$\tilde\Omega(n^2)$ [uncertain]</td>
</tr>
</tbody>
</table>


## Source table 1: rounds, messages, and energy

<table class="bordered-table">
<thead>
<tr>
<th scope="col" markdown="span">Problem</th>
<th scope="col" markdown="span">Rounds</th>
<th scope="col" markdown="span">Messages</th>
<th scope="col" markdown="span">Energy</th>
</tr>
</thead>
<tbody>
<tr><th class="table-section" colspan="4" markdown="span">Local problems</th></tr>
<tr>
<td markdown="span">MIS</td>
<td markdown="span">$\Omega(\sqrt{\log n/\log\log n})$ [[KMW '04]](https://www.microsoft.com/en-us/research/publication/cannot-computed-locally/)<br>$O(\log\Delta+\log^5\log n)$ [[Gha '16]](https://arxiv.org/abs/1506.05093)</td>
<td markdown="span">$\tilde\Theta(m)$ [[PPPRR '17]](https://arxiv.org/abs/1705.07861)</td>
<td markdown="span">$O(\log\log n)$ [[DMP '23]](https://arxiv.org/abs/2204.08359)</td>
</tr>
<tr>
<td markdown="span">Maximal matching</td>
<td markdown="span">$\Omega(\sqrt{\log n/\log\log n})$ [[KMW '04]](https://www.microsoft.com/en-us/research/publication/cannot-computed-locally/)<br>$O(\log\Delta+\log^4\log n)$ [[BEPS '16]](https://arxiv.org/abs/1202.1983)</td>
<td markdown="span">$\tilde\Theta(n^2)$ [[DPPPR '24]](https://arxiv.org/abs/2311.14811)</td>
<td markdown="span">?</td>
</tr>
<tr>
<td markdown="span">$\Delta+1$ vertex coloring</td>
<td markdown="span">$\Omega(\log^*n)$ [[Lin '92]](https://courses.csail.mit.edu/6.852/08/papers/Linial.pdf)<br>$O(\log n)$ [[Lin '92]](https://courses.csail.mit.edu/6.852/08/papers/Linial.pdf)</td>
<td markdown="span">?</td>
<td markdown="span">?</td>
</tr>
<tr>
<td markdown="span">$\Delta+1$ edge coloring</td>
<td markdown="span">$\Omega(\log^*n)$ [[Lin '92]](https://courses.csail.mit.edu/6.852/08/papers/Linial.pdf)<br>$O(\Delta+\log^*n)$ [[BE '09]](https://www.cs.bgu.ac.il/~elkinm/fp136-barenboim.pdf)</td>
<td markdown="span">$\tilde O(m)$ [[BE '09]](https://www.cs.bgu.ac.il/~elkinm/fp136-barenboim.pdf)</td>
<td markdown="span">?</td>
</tr>
<tr>
<td markdown="span">$\Delta^2$ edge coloring</td>
<td markdown="span">$O(\log^*n)$ [[Lin '92]](https://courses.csail.mit.edu/6.852/08/papers/Linial.pdf)</td>
<td markdown="span">$\tilde O(m)$ [[Lin '92]](https://courses.csail.mit.edu/6.852/08/papers/Linial.pdf)</td>
<td markdown="span">?</td>
</tr>
<tr>
<td markdown="span">Constant-approximation minimum vertex cover</td>
<td markdown="span">$O(\log\Delta/\log\log\Delta)$ [[BCS '16]](https://arxiv.org/abs/1602.03713)</td>
<td markdown="span">$\tilde\Theta(n^2)$ [[DPPPR '24]](https://arxiv.org/abs/2311.14811)</td>
<td markdown="span">?</td>
</tr>
<tr>
<td markdown="span">Constant-approximation minimum dominating set</td>
<td markdown="span">?</td>
<td markdown="span">$\tilde\Theta(n^2)$ [[DPPPR '24]](https://arxiv.org/abs/2311.14811)</td>
<td markdown="span">?</td>
</tr>
<tr>
<td markdown="span">Constant-approximation maximum matching</td>
<td markdown="span">?</td>
<td markdown="span">$\tilde\Theta(n^2)$ [[DPPPR '24]](https://arxiv.org/abs/2311.14811)</td>
<td markdown="span">?</td>
</tr>
<tr>
<td markdown="span">Constant-approximation maximum independent set</td>
<td markdown="span">?</td>
<td markdown="span">$\tilde\Theta(n^2)$ [[DPPPR '24]](https://arxiv.org/abs/2311.14811)</td>
<td markdown="span">?</td>
</tr>
<tr>
<td markdown="span">Triangle listing</td>
<td markdown="span">$O(n^{1/3})$ [[DLP '12]](https://arxiv.org/abs/1201.6652)</td>
<td markdown="span">$\tilde O(mn^{1/3})$</td>
<td markdown="span">$\Theta(n^{1/3}/\log n)$ [unpublished] [[DLP '12]](https://arxiv.org/abs/1201.6652)</td>
</tr>
<tr><th class="table-section" colspan="4" markdown="span">Global problems with low congestion ($O(D)$ rounds)</th></tr>
<tr>
<td markdown="span">Broadcast</td>
<td markdown="span">$\Theta(D)$</td>
<td markdown="span">$O(m)$</td>
<td markdown="span">$O(\log n)$ [via tree]</td>
</tr>
<tr>
<td markdown="span">Leader election (LE)</td>
<td markdown="span">$\Theta(D)$ [[KPPRT '15]](https://pureadmin.qub.ac.uk/ws/portalfiles/portal/17451767/Pure_Jacm_Version.pdf)</td>
<td markdown="span">$\Theta(m)$ [[KPPRT '15]](https://pureadmin.qub.ac.uk/ws/portalfiles/portal/17451767/Pure_Jacm_Version.pdf)</td>
<td markdown="span">$O(\log n)$ [[BM '21]](https://arxiv.org/abs/2108.01963)</td>
</tr>
<tr>
<td markdown="span">2-approximation of diameter</td>
<td markdown="span">$\Theta(D)$</td>
<td markdown="span">$O(m)$</td>
<td markdown="span">$O(\log n)$ [via tree]</td>
</tr>
<tr>
<td markdown="span">Node count</td>
<td markdown="span">$\Theta(D)$</td>
<td markdown="span">$O(m)$</td>
<td markdown="span">$O(\log n)$ [via tree]</td>
</tr>
<tr>
<td markdown="span">Find $\tilde n\in[n,n^4]$</td>
<td markdown="span">$O(D)$</td>
<td markdown="span">$O(m\log n)$ [via tree]</td>
<td markdown="span">$O(\log n)$ [via tree]</td>
</tr>
<tr>
<td markdown="span">Edge count</td>
<td markdown="span">$\Theta(D)$</td>
<td markdown="span">$O(m)$</td>
<td markdown="span">$O(\log n)$ [via tree]</td>
</tr>
<tr>
<td markdown="span">BFS tree</td>
<td markdown="span">$\Theta(D)$</td>
<td markdown="span">$O(m)$</td>
<td markdown="span">$O(\log^5n)$ [[DH '22]](https://arxiv.org/abs/2205.12830)</td>
</tr>
<tr>
<td markdown="span">DFS tree (tentative classification)</td>
<td markdown="span">$\Omega(D)$<br>$O(n)$ [[Awerbuch '85]](https://groups.csail.mit.edu/tds/papers/Awerbuch/Info-Process-Letters85.pdf)</td>
<td markdown="span">$O(m)$</td>
<td markdown="span">?</td>
</tr>
<tr><th class="table-section" colspan="4" markdown="span">Global problems with medium congestion ($\tilde\Omega(D+\sqrt n)\cap\tilde o(n)$ rounds)</th></tr>
<tr>
<td markdown="span">SSSP</td>
<td markdown="span">$\tilde O(D+\sqrt{n}+n^{2/5+o(1)}D^{2/5})$ [[CF '23]](https://nairenc.github.io/nairenc_files/parallelexactsspsqrt.pdf)</td>
<td markdown="span">$\tilde O(m)$ [[GT '24]](https://arxiv.org/abs/2409.15470)</td>
<td markdown="span">$O(\log^{10}n)$ [This Work]</td>
</tr>
<tr>
<td markdown="span">$(1+\varepsilon)$-SSSP</td>
<td markdown="span">$\tilde\Theta(\varepsilon^{-3}(D+\sqrt{n}))$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049) [[BKKL '16b]](https://arxiv.org/abs/1607.05127)</td>
<td markdown="span">$\tilde O(m)$ [[HHW '18]](https://arxiv.org/abs/1801.05127)</td>
<td markdown="span">$O(\log^{10}n)$ [This Work]</td>
</tr>
<tr>
<td markdown="span">MST</td>
<td markdown="span">$\tilde\Theta(D+\sqrt{n})$ [[PR '00]](https://www.cs.bgu.ac.il/~elkinm/teaching/distr_comp/autumn16/peleg_rub.pdf) [[KP '98]](https://courses.csail.mit.edu/6.852/15/papers/KuttenPeleg.pdf)</td>
<td markdown="span">$\tilde\Theta(m)$ [[KPPRT '15]](https://pureadmin.qub.ac.uk/ws/portalfiles/portal/17451767/Pure_Jacm_Version.pdf) [[PRS '17]](https://arxiv.org/abs/1607.06883)</td>
<td markdown="span">$\Theta(\log n)$ [[AMP '24]](https://arxiv.org/abs/2204.08385)</td>
</tr>
<tr>
<td markdown="span">Minimum cut</td>
<td markdown="span">$\tilde\Theta(D+\sqrt{n})$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049) [[DEMN '21]](https://arxiv.org/abs/2004.09129)</td>
<td markdown="span">$\tilde O(m)$ [[HHW '18]](https://arxiv.org/abs/1801.05127)</td>
<td markdown="span">$O(\log^7n)$ [This Work]</td>
</tr>
<tr>
<td markdown="span">$(1+\varepsilon)$-minimum cut</td>
<td markdown="span">$\tilde\Theta(D+\sqrt{n})$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049) [[DEMN '21]](https://arxiv.org/abs/2004.09129)</td>
<td markdown="span">$\tilde O(m)$ [[HHW '18]](https://arxiv.org/abs/1801.05127)</td>
<td markdown="span">$O(\varepsilon^{-5}\log^4n)$ [This Work]</td>
</tr>
<tr>
<td markdown="span">Maximum flow</td>
<td markdown="span">$n^{1/2+o(1)}(D+\sqrt{n})$ [[de Vos '23]](https://arxiv.org/abs/2304.01600)</td>
<td markdown="span">?</td>
<td markdown="span">$O(n^{1/2+o(1)})$ [This Work]</td>
</tr>
<tr>
<td markdown="span">$(1+\varepsilon)$-maximum flow</td>
<td markdown="span">$\tilde O((D+\sqrt{n})n^{o(1)}\varepsilon^{-3})$ [[GKKLP '15]](https://arxiv.org/abs/1508.04747)</td>
<td markdown="span">?</td>
<td markdown="span">?</td>
</tr>
<tr>
<td markdown="span">Minimum-cost maximum flow</td>
<td markdown="span">$\tilde O((D+\sqrt{n})n^{1/2+o(1)})$ [[de Vos '23]](https://arxiv.org/abs/2304.01600)</td>
<td markdown="span">?</td>
<td markdown="span">$O(n^{1/2+o(1)})$ [This Work]</td>
</tr>
<tr>
<td markdown="span">$(1+\varepsilon)$-MCMF</td>
<td markdown="span">?</td>
<td markdown="span">?</td>
<td markdown="span">?</td>
</tr>
<tr>
<td markdown="span">$\varepsilon$-Laplacian</td>
<td markdown="span">$O((D+\sqrt{n})n^{o(1)}\log(\varepsilon^{-1}))$ [[FGLPSY '22]](https://arxiv.org/abs/2012.15675)</td>
<td markdown="span">$\tilde O(m^{1+o(1)})$</td>
<td markdown="span">$n^{o(1)}\log(\varepsilon^{-1})$ [This Work]</td>
</tr>
<tr>
<td markdown="span">Sparsest cut</td>
<td markdown="span">?</td>
<td markdown="span">?</td>
<td markdown="span">?</td>
</tr>
<tr>
<td markdown="span">Sparse cuts</td>
<td markdown="span">?</td>
<td markdown="span">?</td>
<td markdown="span">?</td>
</tr>
<tr><th class="table-section" colspan="4" markdown="span">Global problems with high congestion ($\Omega(n)$ rounds)</th></tr>
<tr>
<td markdown="span">Diameter</td>
<td markdown="span">$\tilde\Theta(n)$ [[FHW '12]](https://citeseerx.ist.psu.edu/document?doi=f8086e9a4637a60405559d731500a980060c3cb7&repid=rep1&type=pdf) [PRT '12 ?]</td>
<td markdown="span">$\tilde\Theta(n^2)$ [[DPPPR '25]](https://arxiv.org/abs/2504.21781)</td>
<td markdown="span">$\Theta(n/\log n)$ [unpublished] [[HFQALSJ '16]](https://qiangshenghua.github.io/papers/spaa16.pdf) [uncertain]</td>
</tr>
<tr>
<td markdown="span">Unweighted APSP</td>
<td markdown="span">$\Theta(n/\log n)$ [uncertain]</td>
<td markdown="span">$\tilde\Theta(n^2)$ [[DPPPR '25]](https://arxiv.org/abs/2504.21781)</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">APSP</td>
<td markdown="span">$\tilde\Theta(n)$ [[FHW '12]](https://citeseerx.ist.psu.edu/document?doi=f8086e9a4637a60405559d731500a980060c3cb7&repid=rep1&type=pdf) [[CKP '17]](https://arxiv.org/abs/1705.05646) [[HFQALSJ '16]](https://qiangshenghua.github.io/papers/spaa16.pdf)</td>
<td markdown="span">$\tilde\Theta(n^2)$ [[DPPPR '25]](https://arxiv.org/abs/2504.21781)</td>
<td markdown="span">$\Theta(n/\log n)$ [unpublished] [[HFQALSJ '16]](https://qiangshenghua.github.io/papers/spaa16.pdf)</td>
</tr>
<tr>
<td markdown="span">Minimum-weight cycle (MWCycle)</td>
<td markdown="span">$\tilde\Theta(n)$ [[MR '24]](https://www.cs.utexas.edu/~vlr/papers/podc2024-proc.pdf) [[BN '19]](https://arxiv.org/abs/1811.03337)</td>
<td markdown="span">$\tilde O(nm)$</td>
<td markdown="span">$\tilde\Theta(n)$ [unpublished] [[MR '24]](https://www.cs.utexas.edu/~vlr/papers/podc2024-proc.pdf)</td>
</tr>
<tr>
<td markdown="span">All-pairs minimum cut (APMC; tentative classification)</td>
<td markdown="span">$\tilde O(n^{3/2+o(1)})$ [This Work]</td>
<td markdown="span">—</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">$(1+\varepsilon)$-APMC (tentative classification)</td>
<td markdown="span">$\tilde O(n)$ [[KX '16]](https://arxiv.org/abs/1402.3851)</td>
<td markdown="span">$\tilde O(n^2)$ [trivial]</td>
<td markdown="span">—</td>
</tr>
<tr><th class="table-section" colspan="4" markdown="span">Global problems with very high congestion ($\Omega(n^2)$ rounds)</th></tr>
<tr>
<td markdown="span">Minimum vertex cover</td>
<td markdown="span">$\tilde\Theta(n^2)$ [[CKP '17]](https://arxiv.org/abs/1705.05646)</td>
<td markdown="span">$\tilde\Theta(n^3)$ [[DPPPR '24]](https://arxiv.org/abs/2311.14811)</td>
<td markdown="span">$\tilde\Theta(n^2)$ [unpublished]</td>
</tr>
<tr>
<td markdown="span">Minimum dominating set</td>
<td markdown="span">$\tilde\Theta(n^2)$ [uncertain]</td>
<td markdown="span">$\tilde\Theta(n^3)$ [[DPPPR '24]](https://arxiv.org/abs/2311.14811)</td>
<td markdown="span">$\tilde\Theta(n^2)$ [unpublished]</td>
</tr>
<tr>
<td markdown="span">Maximum independent set</td>
<td markdown="span">$\tilde\Theta(n^2)$ [[CKP '17]](https://arxiv.org/abs/1705.05646)</td>
<td markdown="span">$\tilde\Theta(n^3)$ [[DPPPR '24]](https://arxiv.org/abs/2311.14811)</td>
<td markdown="span">$\tilde\Theta(n^2)$ [unpublished]</td>
</tr>
<tr>
<td markdown="span">Minimum vertex coloring</td>
<td markdown="span">$\tilde\Theta(n^2)$ [[CKP '17]](https://arxiv.org/abs/1705.05646)</td>
<td markdown="span">?</td>
<td markdown="span">?</td>
</tr>
</tbody>
</table>

### Boxed procedure: collecting the entire graph

The notes assume $O(\log n)$ bits of additional data per node and edge and give the following naive $O(m)$-round approach.

| Step | Operation |
| --- | --- |
| 1 | Elect a leader node $r$. |
| 2 | Construct a BFS tree rooted at $r$. |
| 3 | Use pipelined upcast to collect all data at $r$ in $O(D+m)$ rounds. |
| 4 | Solve the problem locally at $r$. |
| 5 | Use pipelined broadcast to send the results to every node in $O(D+m)$ rounds. |
{: .bordered-table}

### Boxed procedure: a naive energy bound in LOCAL

The notes attribute the labeled distance tree construction to [[BM '21]](https://arxiv.org/abs/2108.01963) and give the following procedure. They record $O(\log n)$ energy, $\tilde O(n)$ rounds, and $O(n\log n)$ messages, with an explicit question about the message count. They also mention the $\tilde O(D)$-round, $O(\log^5n)$-energy approach of [[DH '22]](https://arxiv.org/abs/2205.12830).

| Step | Operation |
| --- | --- |
| 1 | Create a labeled distance tree rooted at $r$ using $O(\log n)$ energy. |
| 2 | Use upcast to gather all data at $r$ using $O(1)$ energy. |
| 3 | Solve the problem locally at $r$. |
| 4 | Use pipelined broadcast to send results to every node using $O(1)$ energy. |
{: .bordered-table}

## Source table 2: energy in LOCAL, CONGEST, and multi-hop RADIO

| Problem | LOCAL awake complexity | CONGEST awake complexity | Multi-hop RADIO awake complexity |
| --- | --- | --- | --- |
| Maximal matching | — | ?– (upper bound blank) | ?–$O(\log n\log\Delta)$ [[DGHP '23]](https://arxiv.org/abs/2104.09096) |
| Broadcast | $\Theta(\log n)$ [[CDHHLP '18]](https://arxiv.org/abs/1710.01800) | $\Theta(\log n)$ [[CDHHLP '18]](https://arxiv.org/abs/1710.01800) [[BM '21]](https://arxiv.org/abs/2108.01963) | $\Omega(\log n)$–$O(\log n\log\Delta)$ [[CDHHLP '18]](https://arxiv.org/abs/1710.01800) |
| Leader election | — | ?–$O(\log n)$ [[BM '21]](https://arxiv.org/abs/2108.01963) | — |
| Minimum cut | — | $\Omega(\log n)$–$O(\log^7n)$ | $\tilde\Theta(n)$ [[Chang '23]](https://arxiv.org/abs/1805.04071) |
| BFS | — | ?–$O(\log^{26}n)$ [[GT '24]](https://arxiv.org/abs/2409.15470) | ?–$\tilde O(1)$ [[DH '22]](https://arxiv.org/abs/2205.12830) |
| SSSP | — | ?–$O(\log^{26}n)$ [[GT '24]](https://arxiv.org/abs/2409.15470) | — |
| MST | $\Theta(\log n)$ [[AMP '24]](https://arxiv.org/abs/2204.08385) [[BM '21]](https://arxiv.org/abs/2108.01963) | $\Theta(\log n)$ [[AMP '24]](https://arxiv.org/abs/2204.08385) | $\Omega(\log n)$–? [[AMP '24]](https://arxiv.org/abs/2204.08385) |
| Diameter | — | $\tilde\Theta(n)$ (unpublished) | $\tilde\Theta(n)$ [[Chang '23]](https://arxiv.org/abs/1805.04071) |
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
{: .bordered-table}

## Source table 4: randomized versus deterministic CONGEST (incomplete)

Blank deterministic entries are retained from the source; they do not assert that no deterministic algorithm exists. Here $\lambda$ denotes the minimum-cut value.

<table class="bordered-table">
<thead>
<tr>
<th scope="col" markdown="span">Problem</th>
<th scope="col" markdown="span">Randomized rounds</th>
<th scope="col" markdown="span">Deterministic rounds</th>
</tr>
</thead>
<tbody>
<tr><th class="table-section" colspan="3" markdown="span">Local problems</th></tr>
<tr>
<td markdown="span">MIS</td>
<td markdown="span">$\Omega(\sqrt{\log n/\log\log n})$ [[KMW '04]](https://www.microsoft.com/en-us/research/publication/cannot-computed-locally/)<br>$O(\log\Delta+\log^5\log n)$ [[Gha '16]](https://arxiv.org/abs/1506.05093)</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">Maximal matching</td>
<td markdown="span">$\Omega(\sqrt{\log n/\log\log n})$ [[KMW '04]](https://www.microsoft.com/en-us/research/publication/cannot-computed-locally/)<br>$O(\log\Delta+\log^4\log n)$ [[BEPS '16]](https://arxiv.org/abs/1202.1983)</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">$\Delta+1$ edge coloring</td>
<td markdown="span">$\Omega(\log^*n)$ [[Lin '92]](https://courses.csail.mit.edu/6.852/08/papers/Linial.pdf)<br>$O(\Delta+\log^*n)$ [[BE '09]](https://www.cs.bgu.ac.il/~elkinm/fp136-barenboim.pdf)</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">$\Delta^2$ edge coloring</td>
<td markdown="span">$O(\log^*n)$ [[Lin '92]](https://courses.csail.mit.edu/6.852/08/papers/Linial.pdf)</td>
<td markdown="span">—</td>
</tr>
<tr><th class="table-section" colspan="3" markdown="span">Global problems with medium congestion ($\omega(D)\cap o(n)$ rounds)</th></tr>
<tr>
<td markdown="span">SSSP</td>
<td markdown="span">$\tilde\Omega(D+\sqrt n)$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049)<br>$\tilde O(\sqrt{nD})$ [[FN '18]](https://arxiv.org/abs/1711.01364)</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">$(1+\varepsilon)$-SSSP</td>
<td markdown="span">$\tilde\Omega(D+\sqrt n)$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049)<br>$\tilde O(\varepsilon^{-3}(D+\sqrt n))$ [[BKKL '16b]](https://arxiv.org/abs/1607.05127)</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">MST</td>
<td markdown="span">$\tilde\Theta(D+\sqrt n)$ [[PR '00]](https://www.cs.bgu.ac.il/~elkinm/teaching/distr_comp/autumn16/peleg_rub.pdf) [[KP '98]](https://courses.csail.mit.edu/6.852/15/papers/KuttenPeleg.pdf)</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">Minimum cut</td>
<td markdown="span">$\tilde\Theta(D+\sqrt n)$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049) [[DEMN '21]](https://arxiv.org/abs/2004.09129)</td>
<td markdown="span">$\tilde O(\lambda(D+\sqrt n))$</td>
</tr>
<tr>
<td markdown="span">$(1+\varepsilon)$-minimum cut</td>
<td markdown="span">$\tilde\Theta(D+\sqrt n)$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049) [[DEMN '21]](https://arxiv.org/abs/2004.09129)</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">Maximum flow</td>
<td markdown="span">$\tilde\Omega(D+\sqrt n)$–? [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049)</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">$(1+\varepsilon)$-maximum flow</td>
<td markdown="span">$\tilde\Omega(D+\sqrt n)$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049)<br>$(D+\sqrt n)n^{o(1)}$ [[GKKLP '15]](https://arxiv.org/abs/1508.04747)</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">Minimum-cost maximum flow</td>
<td markdown="span">$\tilde\Omega(\sqrt n+D)$ (citation missing in source)<br>$(\sqrt n+D)n^{1/2+o(1)}$ [[de Vos '23]](https://arxiv.org/abs/2304.01600)</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">$(1+\varepsilon)$-MCMF</td>
<td markdown="span">?</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">Laplacian</td>
<td markdown="span">$\tilde\Omega(\sqrt n+D)$ [[FGLPSY '22]](https://arxiv.org/abs/2012.15675)</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">$\varepsilon$-Laplacian</td>
<td markdown="span">$\tilde\Omega(\sqrt n+D)$– (upper bound blank)</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">Sparsest cut</td>
<td markdown="span">?</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">Sparse cuts</td>
<td markdown="span">?</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">$k$-approximation of APSP</td>
<td markdown="span">$\tilde\Omega(D+\sqrt n)$ [[DHKKNPPW '11]](https://arxiv.org/abs/1011.3049)<br>$\tilde O(D+n^{1/2+1/k})$ [[LP '15]](https://arxiv.org/abs/1412.7922)</td>
<td markdown="span">—</td>
</tr>
<tr><th class="table-section" colspan="3" markdown="span">Global problems with high congestion ($\Omega(n)$ rounds)</th></tr>
<tr>
<td markdown="span">Diameter</td>
<td markdown="span">$\Theta(n)$ [[FHW '12]](https://citeseerx.ist.psu.edu/document?doi=f8086e9a4637a60405559d731500a980060c3cb7&repid=rep1&type=pdf) [PRT '12 ?]</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">APSP</td>
<td markdown="span">$\tilde\Theta(n)$ [[LP '15]](https://arxiv.org/abs/1412.7922) [[HFQALSJ '16]](https://qiangshenghua.github.io/papers/spaa16.pdf)</td>
<td markdown="span">—</td>
</tr>
<tr>
<td markdown="span">Minimum-weight cycle</td>
<td markdown="span">$\tilde\Theta(n)$ [[MR '24]](https://www.cs.utexas.edu/~vlr/papers/podc2024-proc.pdf) [[BN '19]](https://arxiv.org/abs/1811.03337)</td>
<td markdown="span">—</td>
</tr>
</tbody>
</table>

## Source table 5: sparsifiers

The columns follow the notation of Section 8.1: $\alpha$ and $\beta$ are the recorded approximation/stretch parameters; "L time" and "C time" are LOCAL and CONGEST round counts, and "Message size" is the recorded message-size bound.

| $\alpha$ | $\beta$ | Size | L time | Message size | C time | Randomness | Reference |
| --- | --- | --- | --- | --- | --- | --- | --- |
| $1+\varepsilon$ | $2-\varepsilon$ | $O(\varepsilon^{-1}n^{3/2})$ | $O(\varepsilon^{-1})$ | $\infty$ | — | Deterministic | [[DGPV '09]](https://dept-info.labri.fr/~gavoille/article/DGPV09.pdf) |
| $1+\varepsilon$ | $O(1/\varepsilon)^{k-1}$ | $O(\varepsilon^{1-k}n^{1+1/k})$ | $O(1)$ | $\infty$ | — | Deterministic | — |
| $1+\varepsilon$ | $k^{\log(\log k/\varepsilon)+O(1)}$ | $O(\beta n^{1+1/k})$ | $n^{o(1)}$ | $\infty$ | — | Deterministic | — |
| $n^{o(1)}$ | $0$ | $n$ | — | — | $n^{o(1)}Q$ | Randomized | [[GKKLP '18]](https://arxiv.org/abs/1508.04747) |
{: .bordered-table}

## Reference notes

- The triangle-listing lower bound was obtained independently by Izumi and Le Gall, [[ILG '17]](https://arxiv.org/abs/1705.09061), and Pandurangan, Robinson, and Scquizzato, [[PRS '18]](https://arxiv.org/abs/1602.08481). Both are credited by [[CS '19]](https://arxiv.org/abs/1904.08037).
- The maximum-independent-set approximation lower bound in the summary follows from the maximum-matching lower bound of [[KMW '16]](https://arxiv.org/abs/1011.5470), also proved by [[CL '21]](https://arxiv.org/abs/2002.06005), through a LOCAL reduction to line graphs. Independent sets in a line graph are matchings in the original graph; the number of vertices grows at most quadratically and the maximum degree by at most a constant factor. LOCAL lower bounds also hold in CONGEST.
- The stronger MaxIS lower bounds of [[EGK '20]](https://arxiv.org/abs/2003.07427) are omitted from the general constant-approximation row: they require specific approximation ratios. Their stated $\log^3n$ denominators are for weighted instances; transferring them to unweighted graphs loses an additional logarithmic factor.
- The $\Delta^2$-edge-coloring upper bounds listed in the summary actually use at most $2\Delta-1$ colors. The topology-gathering baselines solve the problem exactly in each connected component; $D\leq m$ absorbs the diameter term.
- [PRT '12 ?]: David Peleg, Liam Roditty, and Elad Tal, *Distributed Algorithms for Network Diameter and Girth*. A public full-text link was not located.
- The source's [Bec+16a] and [Bec+16b] entries both point to arXiv:1607.05127, under different titles and author lists. Their labels are kept distinct above as [BFKL '16a] and [BKKL '16b], with the shared public link.
- "This Work," "via tree," "trivial," and "unpublished" are source annotations, not additional bibliographic references. The uncited minimum-cost-flow lower bound remains explicitly marked as missing a citation.

