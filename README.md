# iOSExercise
Technology Assessment

**What am I building?**

The final result of this task is to have an View for displaying Album List after getting in a from Api for a random user and after navigating display list of Photos for perticular Album, After tapping on Photo open a detail page for Photo which displaying Photo with title.

**In this project:**

  **Structural Design Pattern**
   - MVVM - Model View ViewModel use for Better UI design


  **Models:**
  - From API data four type of datamodel created those are User,UserAlbum, UserPhoto 
  
  
  **View:**
  - MainHomeView 
  
  - AlbumListView
    - AlbumListItemView
    
  - AlbumDetailView
    - PhotoItemView
    
  - PhotoDetailView
    
   **ViewModel:**
   - AlbumListViewModel - A ViewModel used to get the user and Album list for AlbumListView
   - AlbumViewModel
   
   **Coordinator**
   - AlbumListCoordinator - Module level Coordinator which has AlbumListViewModel , AlbumViewModel
  
   **Services:**
   - AppDataService - a protocal which has definition for All use API and DataFetchService consume this API for network call
   
      **Network:**
       - NetworkService - use NetworkSessionManager for calling network calls
       - NetworkSessionManager - use URLSession to call new request
  
   
   
### Test Cases: ###

   **iOSExerciseTests:**
   - MainHomeViewTests
   - AlbumListViewModelTests
   - AlbumViewModelTests
   
   - AppDataServiceTests
   - NetworkServiceTests

   
   
### Instructions: ###
  - Fork the project
  - Clone the forked project to you'r machine
  - open iOSExercise.xcodeproj with latest Xcode, Build and run 
