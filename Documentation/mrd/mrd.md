<h1 align="center"> Room B Gone</h1>
<h6 align="center">MRD V1.0</h6>
<h6 align="center">Authors: Super Awesome Nice Tiger Team 2</h6>
***
##Table of Contents
+ [Preface](#preface)
+ [Problems](#problems)
+ [Opportunity Size](#opportunity-size)
+ [Current Solutions](#current-solutions)
+ [Proposed Solution](#proposed-solution)
+ [Theory of Operations](#theory-of-operations)
+ [Use Cases](#use-cases)
+ [Business Model](#business-model)

***

##Preface
Our medical office is required to store multitudes of patient files. The files consist of various medical notes, correspondences and financial statements. The documents are stored in folders, and are tabbed by patient name. Patient names may collide, therefore a combination of the patient's name and the last 4 digits of his or her SSN number are used. 
Archiving new correspondences is a semi-weekly process of sorting and filing new documents into their corresponding folders. Files are used by checking them out from a ledger.
Old documents are not removed when new files are created, growing indefinitely.

##Problems
1. Files are stored on premises in 400 square feet. At a cost of $30 per square feet per year, this amounts to $12,000.
2. Files are NOT backed up for off-site storage, which would be an additional expense.
3. Because of the lack of backup, files are at constant risk of loss.
4. Files are stored without encryption, access control or access logs.
5. Sending files requires faxing or copying, even for inter-clinic requests.
6. While files are removed from the file room, their updates are blocked.
7. Paper-based data can not be analysed or searched automatically.
8. Other departments, namely Finance and HR also produce similar files. (And have similar problems.)

##Opportunity Size
According to the American Academy Of Family Physicians, a typical physician sees on average 80 patients per week. Extrapolating from this number we estimate average practice documentation needs are in the range of 1000 files per year. There are over 200,000 physicians practicing in the USA. Half of these on average are on a single provider organization, and the rest on two. [References](#refs)

Making estimated marked size of  200000 practices * 1.5 physician * 1000 files per physician = 300 million files a year.  This is not considering specialists, workman comp, medicare and medicaid practices that are required by law to keep patient files pretty much indefinitely.
Estimated USA population is just over 300 million per latest census.

##Current Solutions
There not single solution to old and true file room, were you can place paper into folder. 
Current solutions are Electronic Health Records, Cloud, Document data stores, and so on.
EHR systems nothing but relational data stores, some with ability to store binary files. EHR records can be manipulated and edited, therefore still requiring paper originals to backup in subpoenas.
Cloud based systems make storage cheap, yet HIPAA regulations require data to be encrypted and encrypted indexes prevent any full text search functionality.
At the same time, cost of storage, and search technology is going down so much that it makes sence to bring storage from cloud back to the “file room” appliance.

##Proposed Solution
Generic virtual file room hardware/software appliance. 
####Document Lingo
We tried to map everything after paper based file room.

+ **Index** – a specific container, for example Medical Records or Finance Department. Same installation can have multiple Indices, documents from which CAN NOT BE cross searched.
+ **Tab** – is a unique index, named after a tab on a file folder. A primary key in RBDMS lingo. Tab is defined by system set up, for example we will use Last Name + First Name + Last 4 digits of SSN as a unique Tab.
+ **Folder** – folder is a collection of document under given Tab
+ **Facet** – A defined dimension in taxonomy, example Gender:Male, DocumentType:Invoice. Facets needs to be defined, Facet values may be defined later or as you go. However Facet value must be defined to be used and available in drop downs.Hence each new facet value automatically added to the Facet, if such permission are set.
+ **Taxonomy** – Collection of Facets
+ **Elasticsearch** – A Open Source Text search engine

####Features
Ability to scan paper documents or import, describe index, OCR, full text search and store indefinitely.
Ability to Full text or facet search for and retrieve documents one by one or as a folder to multiple devices.
Ability to integrate to other systems and ability to back up to off-site.

##Theory of Operations
1. Taxonomy is configured to outline Required Tab indexes and Optional Facet taxonomy.
2. Documents arrive via Mail to Clerk in Envelopes or such.
 1. Documents can be for new patient ar for existing patient's file
3.Clerk Scans images into PDF documents, one document per Envelope using Xi500 Scanner.
4. Clerk catalogues the image by establishing via search IF
 1. New patient: create new folder, therefore new Tab Index shall be created
 2. Add to existing Tab and use its settings
5. Add Taxonomy information if needed. This is END of human interactions
6. Systems background process OCRs the image and stores extracted text along with Facets data in a Elasticsearch engine
7. Documents are ready for search and folders ready for download and use.

<div align="center"><img src="./images/workflow.png" width="80%"></div>

###Appliance
####Overview
Proposed appliance is a “private cloud” architecture. Where multiple Virtual Machines run on single Physical machine. Physical machine is a multicore PC with RAID drive, running Ubuntu 12.04 LTS. The software is running in several VMs inside the appliance as means of separating application layers and provide upgrade or expansion path.
####Architecture
<div align="center"><img src="./images/architecture.png" width="50%"></div>

##Use Cases
####Overview
Documents are stored under a tabs and described via taxonomy. Both Tabs and Taxonomy are user defined. For instance, concept of a TAB may be First+Last+DOB of patient, Taxonomy could be, location, diagnosis, day of service, insurance company, etc., as long as effort of main EHR system is not duplicated.
Further more ALL documents will undergo OCR and full text indexing via Elasticsearch. The full text search together with Tab, Taxonomy and Faceting will create a multiple dimensions across entire file room.
The process of creating and maintaining virtual file room shall be mapped after “real room” and be very simple and flexible.
Entire system shall be on premises, provide security encryption and assess log yet be accessible remotely via tunnel bridge or VPN or even moved to cloud if and when technology will be secure enough. 
Backups shall be automated and available for off-site deposit.
Entire system shall provide flexible and adaptable API to integrate with 3rd party systems.
The check in checkout process shall use iPad style devices, where user can see and search entire file room , to find exactly what needed.

##Business Model
We will supply turn on hardware/software appliance solution and service combination via independent integrators or directly.  Appliance will be leased to the customer via finance company. Services will be provided and priced via tiers.

***
####<a name="refs"></a> References
http://www.aafp.org/about/the-aafp/family-medicine-facts/table-6.html
http://en.wikipedia.org/wiki/Group_medical_practice_in_the_United_States