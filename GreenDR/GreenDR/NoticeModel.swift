class NoticeModel{
    var title: String?
    var time: String?
    var amount: String?
    var contents: String?
    
    init(title: String?, time: String?, amount: String?, contents: String?) {
        self.title = title;
        self.time = time;
        self.amount = amount;
        self.contents = contents;
    }
}
