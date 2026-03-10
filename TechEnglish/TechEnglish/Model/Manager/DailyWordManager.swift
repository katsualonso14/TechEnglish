import Foundation

class DailyWordManager {
    
    static let shared = DailyWordManager()
    
    private let lastShownDateKey = "dailyWordLastShownDate"
    private let lastShownWordIndexKey = "dailyWordLastShownIndex"
    private let lastShownCategoryKey = "dailyWordLastShownCategory"
    
    private init() {}
    
    func shouldShowDailyWord() -> Bool {
        let lastShownDate = UserDefaults.standard.string(forKey: lastShownDateKey) ?? ""
        let today = getTodayString()
        return lastShownDate != today
    }
    
    func markAsShown() {
        let today = getTodayString()
        UserDefaults.standard.set(today, forKey: lastShownDateKey)
    }
    
    func getRandomWord() -> (word: String, pronunciation: String, meaning: String, example: String)? {
        let vocabList = VocabularyList()
        
        var allWords: [String] = []
        var allPronunciations: [String] = []
        var allMeanings: [String] = []
        var allExamples: [String] = []
        
        allWords.append(contentsOf: vocabList.errorSentence)
        allPronunciations.append(contentsOf: vocabList.errorPronunciation)
        allMeanings.append(contentsOf: vocabList.errorEnglish)
        allExamples.append(contentsOf: vocabList.errorExampleSentence)
        
        allWords.append(contentsOf: vocabList.docsSentence)
        allPronunciations.append(contentsOf: vocabList.docsPronunciation)
        allMeanings.append(contentsOf: vocabList.docsEnglish)
        allExamples.append(contentsOf: vocabList.docsExampleSentence)
        
        allWords.append(contentsOf: vocabList.dataSentence)
        allPronunciations.append(contentsOf: vocabList.dataPronunciation)
        allMeanings.append(contentsOf: vocabList.dataEnglish)
        allExamples.append(contentsOf: vocabList.dataExampleSentence)
        
        allWords.append(contentsOf: vocabList.lifecycleSentence)
        allPronunciations.append(contentsOf: vocabList.lifecyclePronunciation)
        allMeanings.append(contentsOf: vocabList.lifecycleEnglish)
        allExamples.append(contentsOf: vocabList.lifecycleExampleSentence)
        
        allWords.append(contentsOf: vocabList.settingSentence)
        allPronunciations.append(contentsOf: vocabList.settingPronunciation)
        allMeanings.append(contentsOf: vocabList.settingEnglish)
        allExamples.append(contentsOf: vocabList.settingExampleSentence)
        
        allWords.append(contentsOf: vocabList.testSentence)
        allPronunciations.append(contentsOf: vocabList.testPronunciation)
        allMeanings.append(contentsOf: vocabList.testEnglish)
        allExamples.append(contentsOf: vocabList.testExampleSentence)
        
        allWords.append(contentsOf: vocabList.otherSentence)
        allPronunciations.append(contentsOf: vocabList.otherPronunciation)
        allMeanings.append(contentsOf: vocabList.otherEnglish)
        allExamples.append(contentsOf: vocabList.otherExampleSentence)
        
        guard !allWords.isEmpty else {
            return nil
        }
        
        let randomIndex = Int.random(in: 0..<allWords.count)
        
        return (
            word: allWords[randomIndex],
            pronunciation: allPronunciations[randomIndex],
            meaning: allMeanings[randomIndex],
            example: allExamples[randomIndex]
        )
    }
    
    private func getTodayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}
