import Foundation

final class Resources {
	enum Localization {
		enum TasksList {
			static let titlePage = "MoviesRx"
			static let rightBarBntString = "Add"
		}

		enum AddTask {
			static let titlePage = "Add task"
			static let rightBarBntString = "Save"
			static let titleTextFieldPlaceholder = "Task title"
			static let descrTextFieldPlaceholder = "Task desription"
		}

		enum TasksSegmentControl {
			static let allPriorities = "All"
			static let lowPriority = "Low"
			static let mediumPriority = "Medium"
			static let highPriority = "High"
		}
		
		enum MovieList {
			static let titleTextFieldPlaceholder = "Task title"
			static let descrTextFieldPlaceholder = "Task desription"
		}

		enum MovieListSegmentControl {
			static let new = "New"
			static let popular = "Popular"
			static let upcoming = "Upcoming"
		}
	}
}
