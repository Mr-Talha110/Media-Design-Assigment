
# **Flutter Assignment: Product Order App**  
**State Management**: Riverpod  
**Architecture**: MVVM (Model-View-ViewModel)  

---

## **Features**  
1. **Product Entry**  
   - Users can add a product **name** and **quantity**.  
   - Product name field provides **auto-suggestions** (fetched from an API).  

2. **Product Notes/Images**  
   - **Double-tap** the name field to add optional notes or images.  

3. **Order Confirmation Screen**  
   - Displays:  
     - Order number  
     - Product name(s)  
     - Delivery location  
     - Date  
     - Quantity  
   - **Submit button** to navigate to the Order Preview screen.  

4. **Order Preview Screen**  
   - Summary of all products added for final review.  

---

## **Technical Implementation**  

### **1. Organized Code Structure**  
- **Strings, Assets, Fonts**:  
  - Separated into dedicated classes (e.g., `AppStrings`, `AppAssets`) for:  
    - **Maintainability**: Easy to update text/fonts globally.  
    - **Consistency**: Avoids hardcoded values across the app.  
    - **Localization Ready**: Simplifies future multi-language support.  

- **Contextless Navigation**:  
  - Implemented a **custom router** (e.g., `AppRouter` or `NavigationService`) to:  
    - Decouple navigation from UI layers (no `BuildContext` dependency).  
    - Simplify testing and reuse.  

- **Extensions**:  
  - Added reusable extensions (e.g., `space()`, `opacity()`) for:  
    - Cleaner UI code (e.g., `Text("Hello").opacity(0.5)`).  
    - Reduced boilerplate for common styling tasks.  

### **2. Network Layer**  
- **Dedicated `network` folder**:  
  - Contains:  
    - **Generic API functions** (e.g., `ApiClient` for GET/POST requests).  
    - **Error handling** (consistent API error responses).  
    - **Mock/Prod environment support** (if applicable).  

---

## **Setup**  
1. Clone the repo:  
   git clone https://github.com/Mr-Talha110/Media-Design-Assigment

2. Install dependencies:  
   flutter pub get  
   
3. Run the app:  
   flutter run  

---

## **Why These Choices?**  
- **Scalability**: MVVM + Riverpod ensures clean state management as the app grows.  
- **Readability**: Extensions and organized resources make code self-documenting.  
- **Testability**: Decoupled navigation and network layer ease unit testing.  

--- 

