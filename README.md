Recommended Environment  
This project is recommended to be run on MATLAB 2020 or later.


Setup Instructions  
Download FieldTrip and save it to the C drive.  
https://github.com/fieldtrip/fieldtrip/releases/tag/20250318

Prepare Required Files  
Save the following folders and files to the C drive:

Three folders (excluding ‘WhiteMatterStreamlineTemplate’):  
  ’script’,‘streamline_template’,‘demodata’

Eight MATLAB script files:  
  ‘Streamline_CorticalMovie5.m’  
  ‘Streamline_STEP7_5.m’  
  ‘Streamline_STEP8_CompOff2.m’  
  ‘Streamline_STEP8_CompOn2.m’  
  ‘Streamline_STEP8_RespOn2.m’  
  ‘Streamline_STEP9_1.m’  
  ‘Streamline_STEP10_1.m’  
  ‘Streamline_STEP11_4.m’  

One Excel file:  
  ‘name_trans_yk1.xlsx’  


Script Descriptions  

‘Streamline_CorticalMovie5.m’   
  Creates videos and snapshots of cortical high-gamma dynamics.

‘Streamline_STEP7_5.m’  
  Detects significant high-gamma augmentation/attenuation in each ROI   
  (approx. 12 minutes total).

‘Streamline_STEP8_CompOff2.m’  
‘Streamline_STEP8_CompOn2.m’  
‘Streamline_STEP8_RespOn2.m’  
  Detect pairs of ROIs that exhibit overlapping high-gamma enhancement/suppression across 5 or more bins   
  (each takes approx. 45 minutes).

‘Streamline_STEP9_1.m’  
  Identifies tracts located in folder C based on the combinations calculated in STEP8   
  (approx. 1 minute total).

‘Streamline_STEP10_1.m’  
  Applies transparency to the appearance/disappearance of tracts in the video   
  (approx. 1 minute total).

‘Streamline_STEP11_4.m’  
  Creates videos and snapshots of functional connectivity.
