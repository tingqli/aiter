import csv,collections,json,glob,re,sys
f=sys.argv[1]
rows=list(csv.DictReader(open(f)))
print(rows[0]['Instruction'][:90])
tot=sum(int(r['Latency']) for r in rows)
cat=collections.defaultdict(lambda:[0,0,0])
for r in rows:
    ins=r['Instruction']
    if not ins or ins.startswith(';'): continue
    op=ins.split()[0]; m=op
    for p in ['s_waitcnt vmcnt','s_waitcnt lgkmcnt','s_waitcnt','buffer_load','buffer_store','global_load','ds_read','ds_write','v_mfma','s_barrier','s_nop','v_','s_']:
        if ins.startswith(p): m=p;break
    c=cat[m];c[0]+=int(r['Hitcount']);c[1]+=int(r['Latency']);c[2]+=int(r['Stall'])
hc=collections.Counter(r['Hitcount'] for r in rows).most_common(3); print('hitcounts',hc)
loop_hits=max(int(h) for h,_ in hc)
print('total lat',tot)
for k,v in sorted(cat.items(),key=lambda x:-x[1][1]): print(f"{k:18s} lat={v[1]:9d} ({100*v[1]/tot:5.1f}%) stall={v[2]:8d} per_iter={v[1]/loop_hits:7.0f}")
for r in sorted(rows,key=lambda r:-int(r['Latency']))[:12]:
    print(r['Vaddr'],r['Hitcount'],r['Latency'],r['Stall'],r['Instruction'][:70])
d=sys.argv[2]
durs=[]
for g in sorted(glob.glob(d+'/se*.json')):
    j=json.load(open(g));w=j['wave']
    if j['num_insts']>1000: durs.append(w['end']-w['begin'])
print('full waves',len(durs),'dur min/avg/max',min(durs),sum(durs)//len(durs),max(durs))
