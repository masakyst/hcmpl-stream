
jQuery.fn.outerHTML = function(s) {
return (s)
? this.before(s).remove()
: jQuery("<p>").append(this.eq(0).clone()).html();
}

var APP_SQBLOG_WIDGET = {
    VERSION: '1.0.0',
    blog_data: [],
    pos_scroll: 0,
    idx_current: 0,
    scr_speed: 1000,
    scr_interval: 3000,
    interv_inst: null
};
APP_SQBLOG_WIDGET.init_data = function() {
    var rows = $(".row"); 
    var len = rows.length;
    for (var i=0; i<len; i++) {
        var pic     = $(rows[i]).find(".pic").attr('src');
        var title   = $(rows[i]).find(".title").text();
        var date    = $(rows[i]).find(".date").text();
        var name    = $(rows[i]).find(".name").text();
        var message = $(rows[i]).find(".message").text();
        var link    = $(rows[i]).find(".link").text();
        this.blog_data.push({pic:pic, title:title, date:date, name:name, message:message, link:link});
    }
    var htmllines = [];
    for (var i in this.blog_data) {
        htmllines.push(this.row_obj(this.blog_data[i]).outerHTML());
    }
    var box = $("#box");
    box.html(htmllines.join("\r\n"));
    box.scrollTop(this.pos_scroll);
};
APP_SQBLOG_WIDGET.row_obj = function(data) {
    var new_div = $('<div class="row">');
    if (data.pic) {
        new_div.append('<a href="'+ data.link +'" target="_blank"><img src="'+ data.pic +'" width="50" height="50" class="pic"/></a>');
    }
    new_div.append('<a href="'+ data.link +'" target="_blank"><div class="title">'+ data.title +'</div>' + 
                   '<div class="date">'+ data.date +'</div>' + 
                   '<div class="name">'+ data.name +'</div>' + 
                   '<div class="message">'+ data.message +'</div></a>');
    return new_div;
};
APP_SQBLOG_WIDGET.remove_bottom = function() {
    var box = $("#box");
    var rows = $(".row");
    $(rows[rows.length-1]).remove();
    box.scrollTop(this.pos_scroll);
};
APP_SQBLOG_WIDGET.add_top = function() {
    var box = $("#box");
    if (--this.idx_current < 0) {
        this.idx_current = this.blog_data.length - 1; 
    }
    var row = this.row_obj(this.blog_data[this.idx_current]);
    row.animate({opacity:0}, 0);
    box.prepend(row);
    this.pos_scroll += 111;
    box.scrollTop(this.pos_scroll);
};
APP_SQBLOG_WIDGET.scroll_box = function() {
    var box = $("#box");
    this.add_top();
    this.pos_scroll -= 111;
    box.animate({scrollTop:this.pos_scroll}, this.scr_speed, 'swing', function(){
        $(".row:first").animate({opacity:1}, "normal");
        APP_SQBLOG_WIDGET.remove_bottom();
    });
};
APP_SQBLOG_WIDGET.dancing = function() {
    console.log("dancing");
    //this.init_data();
    //this.interv_inst = setInterval(function() {
    //    APP_SQBLOG_WIDGET.scroll_box();
    //}, 3000);
};

APP_SQBLOG_WIDGET.add_tweet = function(tweet) {
    console.log(tweet);
    var container = $("#container");
    var box = $("#box");

    var line = $('<hr class="featurette-divider">'
             + '<div class="featurette">'
             + '<img class="featurette-image pull-left" src="' + tweet.user.profile_image_url + '" width="200">'
             + '<h2 class="featurette-heading">' + tweet.user.screen_name + ' <span class="muted">@masakyst</span></h2>'
             + '<p class="lead">' + tweet.text + '</p>'
             + '</div>');
    line.animate({opacity:0}, 0);
    box.prepend(line);
    //box.animate({scrollTop:0}, 1000, 'swing', function(){
        $(".featurette:first").animate({opacity:1}, 1000);
        //APP_SQBLOG_WIDGET.remove_bottom();
    //});


};

