# RijksMuseum

## Install

* Install [Swiftlint](https://github.com/realm/SwiftLint) on your machine
* Check SPM chaces first
* Build and run

## App Structure

* I used **MVVM** with a simple router and observation with only UIKit, no Combine.

* OpenSource solution for chacing (**ImagePool**)

* I used SwiftFormat and SwiftLint to enhance Swift style.

* I used **SPM** (Swift Package Manager) only for *SnapKit*.

* I used Sourcery to create most of the Mocks for the Unit Test.

* When there is an API error or not internet connection, instead of show a popup error I hide the list result showing a placeholder. Similar approach for the Details view.

## Future Improvments

* The UICollectionView is ready to manage different sections with header, but in this first version I get only the painting collection.
