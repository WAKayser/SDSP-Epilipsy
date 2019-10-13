# SDSP-Epilipsy

## Information from the website

### Description
Epilepsy, the second most common neurological disorder after stroke, occurs in over 0.5% of the world population. The electroencephalogram (EEG) measures the electrical activity of the brain and is a well-established technique in epilepsy diagnosis and monitoring. With a fine temporal resolution, an EEG can provide accurate information about the onset of the seizure.

A classifier is needed to quickly detect the onset of the seizure as it occurs. In this assignment, you will try to model the EEG signal using AR modeling, and develop a change detection algorithm on the model parameters.

### Starting literature

    T. N. Alotaiby, S. A. Alshebeili, T. Alshawi, I. Ahmad, and F. E. A. El-Samie, "EEG seizure detection and prediction algorithms: a survey," EURASIP Journal on Advances in Signal Processing, vol. 2014, no. 1, p. 183, 2014.
    R. M. Rangayyan, Biomedical signal analysis, vol. 33. John Wiley and Sons, 2015.
    L. Sornmo and P. Laguna, Bioelectrical signal processing in cardiac and neurological applications. Elsevier Academic Press, 2005. ISBN: 978-0-12-437552-9. 

### Consultant
dr. Borbala Hunyadi
Email: b.hunyadi@tudelft.nl
Room: HB 17.120 

## Information from the mail
There are 3 variables in the .mat file:
EEG - this is large segment of EEG data, recorded with 21 channels (the 22nd channels was an ECG but I deleted this channel from the dataset, not relevant here)
FP1segment - this is a short, 30s long segment of EEG data from the 11th channel. The name of this channel is FP1. This segment corresponds to the image I included in the assignment text. You can complete the whole assignment using only this segment. (There rest of the data, in the EEG variable is there for your interest)
headerEEG - some information about the recording per channel. The most important fact is that the sampling rate was 250Hz.

I don’t have any other particular pointer. Read the assignment carefully and try to answer each question in there.
You can use methods you learnt during the course. There is no need to use complicated algorithms for the literature. The paper I recommend in the assignment text is just for you information: to see how much research is being done on seizure detection; and that you can orient yourself the most important research questions. Nevertheless, the questions you  need to answer in the report are the questions form the assignment text.
