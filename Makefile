BOOKS=alice christmas_carol dracula frankenstein heart_of_darkness life_of_bee moby_dick modest_proposal pride_and_prejudice tale_of_two_cities ulysses

FREQLISTS=$(BOOKS:%=results/%.freq.txt)
SENTEDBOOKS=$(BOOKS:%=results/%.sent.txt)
NO_MD=$(BOOKS:%=data/%.no_md.txt)

all: $(FREQLISTS) $(SENTEDBOOKS) $(NO_MD)

%.no_md.txt: %.txt
	python3 src/remove_gutenberg_metadata.py $< $@

clean:
	rm -f results/* data/*no_md.txt

results/%.freq.txt: data/%.no_md.txt 
	src/freqlist.sh $< $@

results/%.sent.txt: data/%.no_md.txt
	src/sent_per_line.sh $< $@

data/all.no_md.txt: $(NO_MD)
	cat $^ > $@

results/all.freq.txt: data/all.no_md.txt
	src/freqlist.sh $< $@

results/all.sent.txt: data/all.no_md.txt
	src/sent_per_line.sh $< $@


