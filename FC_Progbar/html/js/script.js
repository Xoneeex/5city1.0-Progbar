var cancelledTimer = null;

$('document').ready(function() {
    FC_Progbar = {};

    FC_Progbar.Progress = function(data) {
        clearTimeout(cancelledTimer);
        $(".progressbar-container").fadeIn(300);
        $(".progressbar-title").text(data.label);
        $(".progressbar-progress").stop().css({"width": "0%", "background-color": "#a981e8"}).animate({
          width: '100%'
        }, {
          duration: parseInt(data.duration),
          complete: function() {
            $(".progressbar-container").fadeOut(300);
            setTimeout(function(){
                $(".progressbar-progress").css("width", 0);
            }, 300)
            $.post('http://FC_Progbar/actionFinish', JSON.stringify({
                })
            );
          }
        });
    };

    FC_Progbar.ProgressCancel = function() {
        $(".progressbar-container").fadeIn(300);
        $(".progressbar-title").text("ANULOWANO");
        $(".progressbar-progress").stop().css( {"width": "100%", "background-color": "#a981e8"});

        cancelledTimer = setTimeout(function () {
            $(".progressbar-container").fadeOut(300);
            setTimeout(function(){
                $(".progressbar-progress").css("width", 0);
            }, 300)
            $.post('http://FC_Progbar/actionCancel', JSON.stringify({
                })
            );
        }, 1000);
    };

    FC_Progbar.CloseUI = function() {
        $('.main-container').css({"display":"none"});
        $(".character-box").removeClass('active-char');
        $(".character-box").attr("data-ischar", "false")
        $("#delete").css({"display":"none"});
    };
    
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case 'FC_Progbar':
                FC_Progbar.Progress(event.data);
                break;
            case 'FC_Progbar_cancel':
                FC_Progbar.ProgressCancel();
                break;
        }
    })
});