

$(document).ready(function()
  {

    $("body").click
    (
      function(e)
      {
        if( (e.target.id !== "corner-control-wrap") && (e.target.id !== "corner-control") )
        {
          $('#corner-control-wrap').removeClass('clicked');
        }
//console.log(e.target);
        if ( (e.target.id === "theme_bg") || (e.target.id === "inner_wrap")  || (e.target.id === "main_user_wrap") )
        {
            $(".tong_tabs > DIV").fadeOut();
        }
      }
    );

    $("#search_user_wrap").click(function() {
      $("#search_notif_not_found").hide();
    });

    $('#SearchedUserDlg').dialog({
            width: 700,
            position:['middle',150],
            autoOpen: false,
            modal: false,
            draggable: false,
            resizable: false,
            dialogClass: "no_header_dlg",
            closeOnEscape: true
    });

    $('#SharePsiDlg').dialog({
            width: 475,
            position:['middle',75],
            autoOpen: false,
            modal: false,
            draggable: false,
            resizable: false,
            title: "Share your Personal Sports Identity (PSI)",
            dialogClass: "no_header_dlg",
            closeOnEscape: true
    });

    $(".welcome_invite #close_welcome_dlg").click(function() {
      setCookieNoLimit('welcome_dlg', 'hide');
      $("#welcome_dlg").fadeOut();
      $("#invited_stamp").fadeOut();
      waitAnim();
      document.location.href="/users/auth/facebook/";
    });

	  $(".ttip").tipTip({maxWidth: "auto", edgeOffset: 10});

    $(".top_ttip").tipTip({maxWidth: "auto", edgeOffset: 10, defaultPosition: "top"});

    $(".bottom_ttip").tipTip({maxWidth: "auto", defaultPosition: "bottom"});

    $(".right_ttip").tipTip({maxWidth: "auto", defaultPosition: "right", edgeOffset: -15});

    $("#share_tab").click(function() {
      displaySharePsiDlg();
    });

    $("#share_psi_onfb").click(function() {
      mixpanel.track("Share PSI on FB");
      sharePsi();
    });



    $("#help_tab").click(function() {
      $("#help_dlg").fadeToggle("slow", "linear");
    });

    $("#help_dlg_close").click(function() {
      $("#help_dlg").fadeOut();
    });

    $("#close_pop_yellow_dialog").click(function() {
      if ($('#pop_yellow_dialog #profile_ttip_hide_next_time').is(':checked')) {
        setCookieNoLimit('fanpage_edit_ttip', 'hide');
      }
      $("#pop_yellow_dialog").fadeOut();
    });

    $("#close_welcome_dlg").click(function() {
      setCookieNoLimit('welcome_dlg', 'hide');
      $("#welcome_dlg").fadeOut();
    });



    $( "#search_user" ).autocomplete({

        source: function( request, response ) {
            $.ajax({
                url: "/search_user",
                data: {
                    name_starts_with: request.term
                },
                success: function( data ) {
                     if (data.length === 0) {
                      $("#search_notif_not_found").show();
                     } else {
                      $("#search_notif_not_found").hide();
                         response( $.map( data, function( item ) {
                            return {
                                label: item.name,
                                name: item.firstname,
                                member: item.member,
                                active: item.active,
                                photo: item.photo,
                                teammate: item.teammate,
                                id: item.id
                            }
                        }));
                     }
                }
            });
        },
      //  minLength: 2,
        select: function( event, ui ) {
           if (ui.item) {
            displaySearchedUser(ui.item);
           // console.log(ui.item);
              // if (ui.item.member != false) {

              //  // document.location.href='/view/'+ui.item.member
              // } else {
              //     alert(ui.item.label+ " is not a member of YoungVarsity\nsend him an invite?") ;
              // }
           }
        }
    });

    $("#tong_main").click(function() {

      if ( $("#tong_nav").hasClass("expanded") ) {
          collapseTongNav();
       }
      else {
        $("#tong_nav").addClass("expanded");
        $(".tong_tabs").show();
      }
    });

    // $("#tong_main").mouseover(function() {
    //   if ( !$("#tong_nav").hasClass("expanded") ) {
    //     $("#tong_nav").addClass("expanded");
    //     $(".tong_tabs").fadeIn();
    //   }
    // });

    $("#tong_wishlist").click(function() {
        mixpanel.track("Tong tab - Wishlist");
        $("#wishlistPrevBtn").toggleClass('selected');
        var cellCount = $("#wishlistPreviewBox > .wishlistPreviewItem").size();
        if (cellCount > 0) {
          var cellsWidth = cellCount * 80;
          $("#wishlistPreviewBox").width(cellsWidth);
        }

        $("#wishlistPreviewBox").fadeToggle("slow", "linear");
        $("#statsPreviewBox").fadeOut("slow", "linear");
        $("#teammatesPreviewBox").fadeOut("slow", "linear");
        $("#fav_teamsPreviewBox").fadeOut("slow", "linear");
        $("#fav_athletesPreviewBox").fadeOut("slow", "linear");
      });

    $("#tong_stats").click(function() {
        mixpanel.track("Tong tab - Stats");
        $("#wishlistPrevBtn").toggleClass('selected');
        $("#statsPreviewBox").fadeToggle("slow", "linear");
        $("#wishlistPreviewBox").fadeOut("slow", "linear");
        $("#teammatesPreviewBox").fadeOut("slow", "linear");
        $("#fav_teamsPreviewBox").fadeOut("slow", "linear");
        $("#fav_athletesPreviewBox").fadeOut("slow", "linear");
        var cellCount = $("#statsPreviewBox .stat_row .stat_col").size();


        var totalStatsRowMaxWidth = 275;
        var statsRowMaxWidth = 275;
          $('#tong_stats #statsPreviewBox').each( function(){
            statsRowMaxWidth = 275;
            $('#tong_stats #statsPreviewBox .stat_row').children().each(
              function(){
                  if ($(this).hasClass('stat_icon')) {
                    statsRowMaxWidth = 0;
                  }
                  statsRowMaxWidth += $(this).width();
              }
            );

            if (totalStatsRowMaxWidth <= statsRowMaxWidth) {
                totalStatsRowMaxWidth = statsRowMaxWidth;
            }

          });

          totalStatsRowMaxWidth += 100; // add some padding

          $("#statsPreviewBox").width( totalStatsRowMaxWidth );
      });

    $("#tong_teammates").click(function() {
        mixpanel.track("Tong tab - Teammates");
        $("#teammatesPrevBtn").toggleClass('selected');
        var cellCount = $("#teammatesPreviewBox > .teammatePreviewItem").size();
        if (cellCount > 0) {
          var cellsWidth = cellCount * 65;
          $("#teammatesPreviewBox").width(cellsWidth);
        }

        $("#statsPreviewBox").fadeOut("slow", "linear");
        $("#wishlistPreviewBox").fadeOut("slow", "linear");
        $("#teammatesPreviewBox").fadeToggle("slow", "linear");
        $("#fav_teamsPreviewBox").fadeOut("slow", "linear");
        $("#fav_athletesPreviewBox").fadeOut("slow", "linear");
      });


    $("#tong_fav_teams").click(function() {
        mixpanel.track("Tong tab - Fav-Teams");
        var cellCount = $("#fav_teamsPreviewBox > .fav_teamsPreviewItem").size();
        if (cellCount > 0) {
          var cellsWidth = cellCount * 55;
          $("#fav_teamsPreviewBox").width(cellsWidth);
        }

        $("#fav_teamsPreviewBox").fadeToggle("slow", "linear");
        $("#statsPreviewBox").fadeOut("slow", "linear");
        $("#wishlistPreviewBox").fadeOut("slow", "linear");
        $("#teammatesPreviewBox").fadeOut("slow", "linear");
        $("#fav_athletesPreviewBox").fadeOut("slow", "linear");
      });

      $("#tong_fav_athletes").click(function() {
        mixpanel.track("Tong tab - Fav-Athletes");
        var cellCount = $("#fav_athletesPreviewBox > .fav_athletesPreviewItem").size();
        if (cellCount > 0) {
          var cellsWidth = cellCount * 55;
          $("#fav_athletesPreviewBox").width(cellsWidth);
        }

        $("#fav_athletesPreviewBox").fadeToggle("slow", "linear");
        $("#statsPreviewBox").fadeOut("slow", "linear");
        $("#wishlistPreviewBox").fadeOut("slow", "linear");
        $("#teammatesPreviewBox").fadeOut("slow", "linear");
        $("#fav_teamsPreviewBox").fadeOut("slow", "linear");
      });


});

  waitAnim = function() {
    $("#anim_overlay_wrap").show();
  }

  stopWaitAnim =  function() {
    $("#anim_overlay_wrap").hide();
  }

  fb_multi_invite = function(fb_ui) {
    mixpanel.track("Invited (multi) FB friend to YV");
    FB.ui({
            method: 'apprequests',
            message: 'Check it out, I\'ve created my own Personal Sports Identity on YoungVarsity',
            title: 'Join me on YoungVarsity',
            data: ''
          },
          function(response) {
            stopWaitAnim();
            if (response) {
              if (response.request ) {
                $.gritter.add({
                        title: ' Invitation',
                        text: 'Sent successfully'
                      });
                } else {
                $.gritter.add({
                        title: ' Invitation',
                        text: 'Error occured while sending invitation'
                      });
              }
            }

          }
        );
  }

  fb_invite = function(fb_ui) {
    mixpanel.track("Invited (single) FB friend to YV");
    FB.ui({
            method: 'apprequests',
            to: fb_ui,
            message: 'Check it out, I\'ve created my own Personal Sports Identity on YoungVarsity',
            title: 'Join me on YoungVarsity',
            data: 'tracking information for the user'
          },
          function(response) {
            stopWaitAnim();
            if (response) {
              if (response.request ) {
                $.gritter.add({
                        title: ' Invitation',
                        text: 'Sent successfully'
                      });
                } else {
                $.gritter.add({
                        title: ' Invitation',
                        text: 'Error occured while sending invitation'
                      });
              }
            }
          }
        );
  }

  sharePsi = function() {
      waitAnim();
      $.ajax({
        url: "/post_psi_on_fb",
        async : true,
        success: function(response) {
         $("#SharePsiDlg").dialog('close');
         stopWaitAnim();
         $.gritter.add({
                title: 'PSI posted on Facebook',
                text: 'Your personal Sports Identity was successfully posted on Facebook'
              });
        }
      });
  }

  displaySharePsiDlg = function() {
    $("#SharePsiDlg").dialog('open');
  }

  closeSearchResDlg = function() {
    $("#SearchedUserDlg").dialog('close');
  }

  prepareUserAndDisplaySearchedUserDlg = function(user_guid, user_fbid, user_name, user_photo) {
    var processedUser = {}
    processedUser.id = user_fbid;
    processedUser.name = user_name;
    processedUser.member = user_guid;
    processedUser.photo = user_photo;
    processedUser.teammate = true;
    processedUser.active = false;

    displaySearchedUser(processedUser);
  }

  displaySearchedUser = function(user) {
    mixpanel.track("Display user inquiry dialog");
    var textInvite = "<span><strong>"+user.name + "</strong> is not on YoungVarsity yet </span>"
    var callOfActInvite  = ' <div class="btnblue btn-smaller right"><a data-remote="true" href="/invite/'+ user.id +'">Invite '+ user.name +'</a></div>';

    var textViewPSI = "<span>Go to <strong>"+user.name + "</strong>'s Personal Sport Identity</span>";
    var callOfActGoPSI  = ' <div class="btnblue btn-smaller right"><a onClick="waitAnim();" href="/view/'+ user.member +'">View '+user.name+'\'s PSI'+ '</a></div>';

    var textAddTeammate = "<span>Mark <strong>"+user.name + "</strong> as a teammate? </span>"
    if (user.member == false) {
      var callOfActAddTeammate  = ' <div class="btnblue btn-smaller right"><a onClick="waitAnim();"  href="/friendfb/'+user.id+'">Add as teammate</a></div>';
    } else {
      var callOfActAddTeammate  = ' <div class="btnblue btn-smaller right"><a onClick="waitAnim();" href="/teammate/'+user.member+'">Add as teammate</a></div>';
    }
    var textRemTeammate = "<span>If <strong>"+user.name + "</strong> is no longer a teammate </span>"
    var callOfActRemTeammate  = ' <div class="btnblue btn-smaller right"><a onClick="waitAnim();"  href="/unfriend/'+ user.member +'">Un-mark teammate</a></div>';

    $("#SearchedUserDlg .photo").empty().append('<img src="'+user.photo+'" />');
    $("#row1").empty(); $("#row2").empty();


    if (user.active == false) { //searched user is not a member on YV
      // display
      if (user.teammate == false) {
        $("#row1").html(textInvite + callOfActInvite);
        $("#row2").html(textAddTeammate + callOfActAddTeammate);
      } else {
        $("#row1").html(textInvite + callOfActInvite);
        $("#row2").html(textRemTeammate + callOfActRemTeammate);
      }
    } else if (user.teammate == true) { //searched user is a member on YV
      $("#row1").html(textViewPSI + callOfActGoPSI);
      $("#row2").html(textRemTeammate + callOfActRemTeammate);
    } else {
      $("#row1").html(textViewPSI + callOfActGoPSI);
      $("#row2").html(textAddTeammate + callOfActAddTeammate);
    }

    $("#SearchedUserDlg").dialog('open');
  }

  collapseTongNav = function() {
      $(".tong_tabs > DIV").hide();
      $(".tong_tabs").hide();
      $("#tong_nav").removeClass("expanded");
  }

  displayUploadProgress = function() {
    $('#upload_progressbar').show();
  }
  hideUploadProgress = function() {
    $('#upload_progressbar').hide();
  }
