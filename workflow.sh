module load nrc/qiime-dependencies/1.9.0 nrc/qiime/1.9.0

## Compute coefficients
#./SparCC.py ./test/otu_test.tsv -i 5 --cor_file=./test/otu_test_cor_sparcc.tsv > ./test/sparcc.log
#./SparCC.py ./test/otu_test.tsv -i 5 --cor_file=./test/otu_test_cor_pearson.tsv -a pearson > ./test/pearson.log
#./SparCC.py ./test/otu_test.tsv -i 5 --cor_file=./test/otu_test_cor_spearman.tsv -a spearman > ./test/spearman.log

## Then bootstrap data 100 times to generate shuffled datasets (resampling...)
mkdir -p test/Resamplings
mkdir -p test/Bootstraps
#./MakeBootstraps.py ./test/otu_test.tsv -n 100 -o ./test/Resamplings/boot

#./SparCC.py ./test/Resamplings/boot_33.txt -i 10 --cor_file=./test/Bootstraps/boot_33.txt >> ./test/bootstrap_sparcc.log 
#for i in `seq 0 100`;
#do
#   ./SparCC.py ./test/Resamplings/boot_$i.txt -i 10 --cor_file=./test/Bootstraps/boot_$i.txt >> ./test/bootstrap_sparcc.log &
#done

## Then compute pvalues from bootstraps.
./PseudoPvals.py ./test/otu_test_cor_sparcc.tsv ./test/Bootstraps/boot 100 -o ./test/pvals_two_sided.txt -t 'two_sided'  > pvalue_log_sparcc.log
