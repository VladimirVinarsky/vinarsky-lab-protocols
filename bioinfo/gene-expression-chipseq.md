---
description: How the graphs for the paper are done
---

# gene-expression-chipseq

## Use cases

1. Plot genes from gene ontology(ies) one group per one graph (from DGE table)
2. Plot genes from gene ontology(ies) multiple groups per one graph (from DGE table)
3. Counting number of genes in chipseq tables
4. Processing the chipseq data

## Data files description

1. `DGE_source-table.xlsx` place where I did the filtering to get the significant genes keeps all data in excel
2. `DGE_all.csv` Table of differential gene expression both significant and non significant&#x20;
3. `DGE_significant.csv` Table of only significant genes coming from `DGE_all.xlsx`
4. `DGE_gene-symbols_all.csv` just the gene symbols of the the `DGE.csv`
5. `DGE_gene-symbols_significant.csv` just the gene symbols of the the `DGE_significant.csv`
6. `data_ChIP-seq_day-10_fixed.csv` The chipseq table containing all the hits

## Data files links

{% file src="../.gitbook/assets/DGE_all.csv" %}

{% file src="../.gitbook/assets/DGE_source-table.xlsx" %}

{% file src="../.gitbook/assets/data_ChIP-seq_day-10_fixed.csv" %}

## Script files

### 1. `DGE_get-unique-gene-symbol.R`

* Takes a single DGE table and returns file with a list of unique genes.
* Is useful to get the list of all genes detected in RNAseq or the significantly disregulated.
* This is a way how to make a filter out of a DGE table which can then be used to filter chipseq data

### 2. `chipseq_get-unique-gene-symbol.R`

* The same as above, but because the original table has `Gene Name`instead of `gene_symbol` as in DGE there are two scripts for this purpose.
* Can be used to create filters to filter the DGE dataset.

### 3. `DGE_read-and-filter_exact-only.R`

* Takes two imputs:
  * several filter files (with list of gene names)
  * single `DGE_*` gene expression table as input.
* Filters the `DGE*`gene expression table.
* Creates an output folder with a date in the name.
* It is case insensitive, but makes exact matches.

### 4. `DGE_plot-top*`

* Takes multiple files which are the outputs from `DGE_read-and-filter...` and creates graph of top x dge genes.
* All files are in an output folder.

### 5. `append_csvs.R`

* Appends csvs created by `DGE_read-and-filter_exact-only.R` for plotting of multiple groups of genes.
* Creates a new column called `gene_ontology` and puts the name of the csv file from which that line came from

### 6. `reformatting-chipseq.R`

* Reformats the `data_Chip-seq_day-10_fixed.csv` to get the binding localizations and intron numbers in nicer format

### 7. `chipseq_read-and-filter_exact-only.R`

* Works the same as the `DGE_read-and-filter... .R` but requires the `data_ChIP-seq_day-10_fixed.csv` files creates the same kind of output in a folder with date.
* Is useful to get the genes which are in the DGE table or in the DGE table of significant genes

### 8. `count-binding-sites.R`

* Takes the reformatted chipseq table (with locations column) and counts the binding sites (all and also in the genes)

### 9. `chipseq_gene-names_by-binding-locations.R`

* Splits the reformatted chipseq table by the different binding locations and outputs the list of genes into csv files

{% file src="../.gitbook/assets/DGE_read-and-filter_exact-only.R" %}

## Specifications

### Filter files

Filter file is a file which contains one `gene_symbol` (for differentail gene expression tables) or `Gene Name` (for chipseq data table) per line. Are used to filter the specified genes out of the abovementioned tables.

#### Gene ontologies filters

Gene onotologies filters are get from [AmiGo2](https://amigo.geneontology.org/amigo).\
The filters are stored in `_filters_gene-onotologies_specific-genes` folder\\

Getting the dataset from amigo2:

1. Select the gene ontology
2. Select homo-sapiens&#x20;
3. Select the gene\_label&#x20;
4. Save with a name of ontology and the GO number as a .txt file

### Other filter files

These are filters for either specific sets of gene

#### Custom filter hand-picked

Write the `gene_symbols` into a text file, one gene per line.

#### Gene groups with common name

For collagens myosins etc using the grep to filter out the names starting with common sequence of characters out of the differentially expressed genes.

`grep -ie '^myl' DGE_gene-symbols_all.csv > filt_myl.csv`

Next open the file and remove the genes you are not intersted in.

## Pipelines

### 1. Processing the Differential expression data to plot single gene ontologies

1. Create the filters.
2. Run the `DGE_read-and-filter_exact-only.csv` on selected filters and `DGE_all.csv`
3. Check the `output_date..` folder for the filtered tables
4. Run the `DGE_plot-top*.R` script on the filtered tables.
5. Check the output graphs in the `graphs_date..` folder and copy the useful ones into a `_selected_graphs` folder

### 2. Processing the Differential expression data to plot multiple gene ontologies in one graph

1. Create the filters.
2. Run the `DGE_read-and-filter_exact-only.csv` on selected filters and `DGE_all.csv`
3. Check the `output_date..` folder for the filtered tables
4. Run the `append_csvs.R` to create on files from the previous step
5. Run the `DGE_plot-vertical-grouped.R` script on the table of appended csvs.
6. Check the output graphs in the `graphs_date..` folder and copy the useful ones into a `_selected_graphs` folder

### 3. Counting number of genes in chipseq tables

The chipseq dataset contains multiple entries for single gene. In order to get the list of unique genes in the table or its subset use the `chipseq_get-unique-gene-symbols.R` to get the list of the genenames where it is easy to count the genes when opening it in excel.

### 4. Processing the chipseq data

1. run the `reforrmatting-chipseq.R` script on the `data_ChIP-seq_day-10_fixed.csv` to get additional columns `location` (contains the location of binding promoter, intron, exon, 3UTR etc) and `intron_number` (numbers of introns from 1to5) in a file called `chipseq_with_locations.csv` in `output_date..` folder. Rename it to `chipseq_with_locations_all.csv`
2. Run the `chipseq_read-and-filter_exact-only.R` with filter `DGE_gene-symbols_significant.csv` on `chipseq_with_locations_all` to get only the non-significantly disregulated genes. Rename it to `chipseq_with_locations_signif.csv`
3. Run the `count-binding-sites.R` on the `chipseq_with_locations_all.csv` to count the YAP1 binding to:
   * locations (intron, exon, promoter etc) - count all the binding sites (can bind to more site in one location of one gene)
   * introns 1 to 5 -count all the sites (again can bind more times in intron 1 for example)
   * locations but count just the genes where it bound
   * introns 1 to5 count just the genes where it is bound
4. Run the `chipseq_gene-names_by-binding-locations.R` on the `chipseq_with_locations_all.csv` to get the gene name sets for all the locations and the introns 1 to 5 in detail in `output_date...` folder.
