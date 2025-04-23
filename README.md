
# **Flutter Assignment: Product Order App**  
**State Management**: Riverpod  
**Architecture**: MVVM (Model-View-ViewModel)  

## **Features**  
1. **Product Entry**  
   - Users can add a product **name** and **quantity**.  
   - Product name field provides **auto-suggestions** (fetched from an API).  

2. **Product Notes/Images**  
   - **Double-tap** the name field to add optional notes or images for the product.  

3. **Order Confirmation Screen**  
   - Displays:  
     - Order number  
     - Product name(s)  
     - Delivery location  
     - Date  
     - Quantity  
   - **Submit button** to proceed to the Order Preview screen.  

4. **Order Preview Screen**  
   - Summary of all products added for final review.  

## **Key Implementation Details**  
- **API Integration**: Fetches product suggestions dynamically.  
- **State Management**: Riverpod for clean state handling.  
- **Navigation**: Seamless flow between screens.  

## **Setup**  
1. Clone the repo:  
   git clone github.com/Mr-Talha110/Media-Design-Assigment

2. Install dependencies:  
   flutter pub get  

3. Run the app:  
   flutter run  

