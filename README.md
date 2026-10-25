<!--
GA4 README template.
- Add your answers to each question's section below.
- For each question where we want you to add your commands,
  put the command(s) you ran in the terminal in the corresponding ```bash code block.
- Where we want to see a command's output, there is a plain ``` code block
  right below the command block: paste the output there.
- You don't need to paste the contents of your scripts into this file:
  we will look at the scripts in your `scripts` dir directly
  (so make sure you commit them!).
- Delete instructional comments like this one as you go.
-->

# GA4 answers - Keeley Alexander

------------------------------------------------------------------------

## Part A: Your project dir and Git repo

### 1: Create subdirs, and copy `CLAUDE.md` and a FastQC report

<!-- No command/output needed. -->

### 2: Initialize a Git repository, and commit your first files

<!-- No command/output needed here -- we check the repo directly. -->

------------------------------------------------------------------------

## Part B: A TrimGalore script --- without genAI

<!-- Reminder: no genAI in this Part! -->

### 3: A TrimGalore container, its help info, and three options

*Answer*: The container link (URI) is: oras://community.wave.seqera.io/library/trim-galore:2.3.0--a56e49e832976df4

Code to run `trim_galore --help` with the container:

```bash
# Your command: apptainer exec "oras://community.wave.seqera.io/library/trim-galore:2.3.0--a56e49e832976df4" trim_galore --help
```

<!-- You don't need to paste the TrimGalore help output -->

*Answer*: The option to indicate that the reads are paired-end: --paired

*Answer*: The option to set the output dir: -o, --output_dir

*Answer*: The option to run FastQC on the trimmed FASTQ files: --fastqc

### 4: Default thresholds

*Answer*: A) The default base quality score threshold: 20

*Answer*: B) The default read length threshold: 20

### 5: Write the `trimgalore.sh` script

<!-- No need to paste the script: we'll look at scripts/trimgalore.sh directly. -->

### 6: Run the script for sample `S63`, and check the output files

Code to run the script:

```bash
# Your command:bash scripts/trimgalore.sh ../garrigos/fastq/S63_R1.fastq.gz ../garrigos/fastq/S63_R2.fastq.gz results/trimgalore
```

<!-- You don't need to paste the TrimGalore logging output -->

Code to list the output files:

```bash
# Your command:ls -l results/trimgalore/
```

The output of the command was:

```
total 51090
-rw-rw----+ 1 keeleyalexander PAS3493     2642 Oct 24 11:40 S63_R1.fastq.gz_trimming_report.json
-rw-rw----+ 1 keeleyalexander PAS3493     2334 Oct 24 11:40 S63_R1.fastq.gz_trimming_report.txt
-rw-rw----+ 1 keeleyalexander PAS3493   294222 Oct 24 11:40 S63_R1_val_1_fastqc.html
-rw-rw----+ 1 keeleyalexander PAS3493   362532 Oct 24 11:40 S63_R1_val_1_fastqc.zip
-rw-rw----+ 1 keeleyalexander PAS3493 25243630 Oct 24 11:40 S63_R1_val_1.fq.gz
-rw-rw----+ 1 keeleyalexander PAS3493     2318 Oct 24 11:40 S63_R2.fastq.gz_trimming_report.json
-rw-rw----+ 1 keeleyalexander PAS3493     2396 Oct 24 11:40 S63_R2.fastq.gz_trimming_report.txt
-rw-rw----+ 1 keeleyalexander PAS3493   279650 Oct 24 11:41 S63_R2_val_2_fastqc.html
-rw-rw----+ 1 keeleyalexander PAS3493   341189 Oct 24 11:41 S63_R2_val_2_fastqc.zip
-rw-rw----+ 1 keeleyalexander PAS3493 25740011 Oct 24 11:40 S63_R2_val_2.fq.gz
```

*Answer*: What each type of output file contains:
.htlm = gives the fastqc report with quality and content 
.zip = same as html but zipped
.fq.gz = the trimmed sequence reads 
.json = shows the commands and steps the container took in processing the file 
.txt = gives an overview of how many sequences were processed, how many were removed, and why they were removed

<!-- If your script failed at first: describe the problem and your fix here. -->

### 7: Trimming results

*Answer*: Which adapter sequence TrimGalore looked for, and how it decided on this: Illumina adapter. there was a hit for this adapter sequence

*Answer*: Percentage of reads with adapters in R1 and R2: 13% and 10%

*Answer*: In R1 and R2, were more bases removed by quality trimming or by adapter trimming? More were removed from adapter trimming

*Answer*: Percentage of read pairs that were removed: 16.6% and 13.6%

### 8: Poly-G trimming

*Answer*: Did TrimGalore do poly-G trimming, and did you have to tell it to? Yes it did, no I did not specify to.

*Answer*: What TrimGalore concludes about the sequencing technology: It was performed with 2-color chemistry so NovaSeq/NextSeq

*Answer*: Was more poly-G trimming done in R1 or R2? (Optional: any idea why?) more in R2. No good guess, maybe because its read after the R1?

### 9: Compare the FastQC reports before and after trimming

*Answer*: At least two differences between the reports,
and whether things look better in terms of pass/warn/fail status: the total number of sequences in the original file is 500000 and in the new file it is 462984. Also in the new file, the per base N content and overrepresented sequences moved to a green check. Things look better in terms of pass/warn/fail status in this new file

*Answer*: Were the short reads with only `N`s removed?
If so, was that due to the length threshold, or something else? Yes they were removed as seen in the per base N content and sequence length distribution charts. It doesn't look as if it was because of the length threshold since the short reads with n's were 34-36 basepairs. it may be becuase of adapter removal?

*Answer*: Something you didn't expect or are confused about: I'm confused why the sequence length in the new file is 20-74 basepairs whereas in the original file it is 35-74. Is this becuase they trimmed some of them but didn't need to trim the longest one?

------------------------------------------------------------------------

## Part C: Bring in genAI

<!-- Export the conversations for questions 10, 11, 13, and 14 to `doc/ai`. -->

### 10: Sonnet reviews your script

*Answer*: Your prompt: Review this shell script. List the 5 most important problems or improvements, most important first, with a one-sentence reason for each. Don’t change it yet.

*Answer*: Claude's suggestions, and for each, whether you agree, disagree,
or don't understand it, and why: Top 5 issues, most important first:

No usage/purpose comment block — CLAUDE.md requires a header comment stating the script's purpose and a usage line (e.g. # Usage: bash scripts/trimgalore.sh <R1> <R2> <outdir>); missing entirely, so a future reader doesn't know expected arguments.
No input logging — CLAUDE.md requires reporting the inputs at the start; currently only "Starting script" and date are printed, not the actual R1/R2/outdir values, making logs hard to debug.
Variable names don't match convention — r1fastq/r2fastq aren't very descriptive and CONTAINER is fine as a constant, but the script never states what tool/version in a comment near the top, making the container choice (trim_galore 2.3.0) opaque without reading the URL.
Hardcoded version string in final log — echo "Used trim_galore version:2.3.0" is redundant and risks drifting from the actual container tag if the image is ever updated, since the line below already queries the real version.
Blank/extra lines (lines 11-13) — minor style inconsistency; three blank lines between variable assignment and logging is unnecessary and slightly hurts readability

I don't agree with the first suggestion as since I made the script and understand its purpose, i think this line is redundant. I also think my variable descriptions are fine. I did make an error in hardcoding the version which is a mistake. The formatting isn't too big of an issue

*Answer*: Was anything wrong, or in conflict with the course's practices?
Did Claude refer to your `CLAUDE.md` conventions? I do see now that the CLAUDE.md states to have the input logging which is why it gave me that as the first priority suggestion. Nothing about it's suggestions were inherently wrong or went against our courses practice's.

*Answer*: The estimated cost of this conversation (from `/usage`): $0.1484

### 11: Opus reviews your script

*Answer*: The estimated cost of this conversation (from `/usage`): 0.2488

*Answer*: Which suggestions did only one of the two models make? This model suggested I forgot an argument set -u to stop the script with an unbound variable 

*Answer*: Did either model claim something that you know is wrong? I beleive the high effort ones first suggestion that I forgot the set -u is wrong since i have set -euo at the beginning of the script

*Answer*: Did either model check its claims, for example by running commands? no neither ran commands 

*Answer*: Did Opus's review change your mind about any of your answers to question 10? It reaffirmed that I could be more descirptive such as putting a usage comment block and explaining the options. 

*Answer*: How did the costs compare? Which review would you trust more, and why?
Was the difference worth the difference in cost? The cost of the second model was almost double. For this purpose, I don't think it's worth the cost, maybe for a really complciated chat. 

### 12: Run the script with a non-existent file

```bash
# Your command:bash scripts/trimgalore.sh fastqc/r1 fastqc/r2 results/trimgalore/
```

The output of the command was:

```
Starting script trimgalore.sh
Sat Oct 24 08:48:49 PM EDT 2026
INFO:    Using cached SIF image
INFO:    gocryptfs not found, will not be able to use gocryptfs
Error: Input file not found: fastqc/r1
```

*Answer*: What happens, and at which point does the script stop? The script stops after reporting the initial log, before running the container.

### 13: Claude adds a check to your script

*Answer*: Your prompt: In scripts/trimgalore.sh, add a check that both input FASTQ files exist, and exit with an informative error message if they don’t.

```bash
# Your command to test the updated script: bash scripts/trimgalore.sh fastqc/r1 fastqc/r2 results/trimgalore/
```

The output of the command was:

```
Starting script trimgalore.sh
Sat Oct 24 08:51:42 PM EDT 2026
Error: R1 FASTQ file not found: fastqc/r1
```

*Answer*: Does it behave the way Claude claimed it would? CLAUDE claimed it would exit with an error message which it did. The only difference is instead of inut file not found it says R1 FASTQ file not found

*Answer*: Given what you saw in question 12, how useful is this check? I don't think its that useful. I think the systems original error message is sufficient to notify the user that the file path is not correct. 

### 14: Claude writes a loop

*Answer*: Your prompt: Write a for loop that runs scripts/trimgalore.sh for the 7 samples whose IDs start with S6, with output dir results/trimgalore. I will run the loop from the GA4 dir. Only show me the loop: don’t add it to a file, and don’t run it.

The loop that Claude wrote: for sample in S63 S64 S65 S66 S67 S68 S69; do
    bash scripts/trimgalore.sh ../garrigos/fastq/${sample}_R1.fastq.gz ../garrigos/fastq/${sample}_R2.fastq.gz results/trimgalore
done


```bash
bash scripts/trimgalore.sh ../garrigos/fastq/${sample}_R1.fastq.gz ../garrigos/fastq/${sample}_R2.fastq.gz results/trimgalore
```

*Answer*: Does it run the script once per sample? yes

*Answer*: Does it get the correct R2 file for each R1 file? yes

*Answer*: Does it only run for the 7 `S6` samples? yes

*Answer*: Did you change the loop? If so, what did you change and why? At first I changed it to be S6*, that way it will only do the samples starting with S6. And then i realized the for and do commands take care fo this.

### 15: Test and run the loop

The loop with `echo`, to test it:

```bash
# Your loop: for sample in S63 S64 S65 S66 S67 S68 S69; do
    echo bash scripts/trimgalore.sh "../garrigos/fastq/${sample}_R1.fastq.gz" "../garrigos/fastq/${sample}_R2.fastq.gz" "results/trimgalore"
done
```

The output of the loop was:

```
bash scripts/trimgalore.sh ../garrigos/fastq/S63_R1.fastq.gz ../garrigos/fastq/S63_R2.fastq.gz results/trimgalore
bash scripts/trimgalore.sh ../garrigos/fastq/S64_R1.fastq.gz ../garrigos/fastq/S64_R2.fastq.gz results/trimgalore
bash scripts/trimgalore.sh ../garrigos/fastq/S65_R1.fastq.gz ../garrigos/fastq/S65_R2.fastq.gz results/trimgalore
bash scripts/trimgalore.sh ../garrigos/fastq/S66_R1.fastq.gz ../garrigos/fastq/S66_R2.fastq.gz results/trimgalore
bash scripts/trimgalore.sh ../garrigos/fastq/S67_R1.fastq.gz ../garrigos/fastq/S67_R2.fastq.gz results/trimgalore
bash scripts/trimgalore.sh ../garrigos/fastq/S68_R1.fastq.gz ../garrigos/fastq/S68_R2.fastq.gz results/trimgalore
bash scripts/trimgalore.sh ../garrigos/fastq/S69_R1.fastq.gz ../garrigos/fastq/S69_R2.fastq.gz results/trimgalore
```

<!-- You don't need to paste the output of the loop that ran TrimGalore -->

```bash
# Your command(s) to check the output files:
```

The output of the command(s) was:

```

```

*Answer*: Are all 7 samples represented? All samples are represented

### 16: A summary command

*Answer*: Your prompt:

```bash
# The command you got from Claude:  for f in results/trimgalore/*_R1.fastq.gz_trimming_report.txt; do
    sample=$(basename "$f" _R1.fastq.gz_trimming_report.txt)
    pct=$(grep "shorter than the length cutoff" "$f" | cut -f2 | tr -d '()')
    echo "$sample: $pct"
done

```

The output of the command was:

```
S63: 37016 7.4%
S64: 16772 3.4%
S65: 9709 1.9%
S66: 18565 3.7%
S67: 8915 1.8%
S68: 12820 2.6%
S69: 24027 4.8%
```

*Answer*: Did the output look right? If not, what did you do? The output looked right

*Answer*: Does the value for `S63` match your answer to question 7? The value did not match so I inquired claude about this and found out I was counting reads trimmed, not completely removed which s why I got a higher percentage than the 7.4%. This conversation is documented in doc/ai

*Answer*: In your own words, how does the command work? The command first uses * so that the command selects all of the samples. Then it uses grep to the find value, and cut to select the value into echo. 

### 17: Document your genAI use

<!-- No command/output needed here -- we check your `doc/ai` dir in the repo directly. -->

### 18: Update your `CLAUDE.md`

*Answer*: What you added to `CLAUDE.md`, and why: I told claude to first test scripts with echo 

*Answer*: Did Claude follow the new instruction? yes 

### 19: Reflection

*Answer*:

------------------------------------------------------------------------

## Part D: Publish your repo on GitHub

### 20: Create a GitHub repository, push, and create an Issue

<!-- No command/output needed here -- we check your GitHub repo directly. -->
