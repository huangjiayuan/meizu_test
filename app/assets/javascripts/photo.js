$(function () {
    $("#choos_tag").val('');
    get_tags();
    page_photo(1);
})
function get_tags() {
    $.get('/photos/tags',
        {
        },
        function (data, status) {
            if (status == 'success') {
                //alert("success");
                $(".tag").html(data);
            } else {
                ;
            }
        });
}
function set_and_find(obj) {
    $("#choos_tag").val(obj.id);
    page_photo(1);
}
function page_photo(page){
    $.get('/photos/page',
        {
            tag_id:$("#choos_tag").val(),
            page:page
        },
        function (data, status) {
            if (status == 'success') {
                //alert("success");
                $(".photo").html(data);
            } else {
                ;
            }
        });
}
$("#uploadpage").click(function () {
//    alert('1');
    $("#choos_tag").val('');
    page_photo(1);
})
function change_tag(obj) {
    var inid = 'in' + obj.id;
    var placeholder = $("#"+obj.id).html();
    var htmlString = '<input type="text" onblur="update_tag(this)" id="'+ inid +'" value="" placeholder="'+ placeholder +'"> '
    if (placeholder.indexOf('input') < 1) {
        $("#"+obj.id).html(htmlString);
        $("#in"+obj.id).focus();
    }
}
function update_tag(obj) {
    $.post('/photos/update_photo_tag',
        {
            photo_id:obj.id.trim().replace("inol",""),
            tag_title:$("#"+obj.id).val().trim()
        },
        function (data, status) {
            if (status == 'success') {
                //alert("success");
                get_tags();
                page_photo(1);
            } else {
                ;
            }
        });
}
function upload(obj) {
    var file = obj.files[0];

    var filename =file.name.split(".")[0];
    if (file) {
        var url = null ;
        if (window.createObjectURL!=undefined) { // basic
            url = window.createObjectURL(file) ;
        } else if (window.URL!=undefined) { // mozilla(firefox)
            url = window.URL.createObjectURL(file) ;
        } else if (window.webkitURL!=undefined) { // webkit or chrome
            url = window.webkitURL.createObjectURL(file) ;
        }
        $("#fileName").val(filename);
        $('#frameFile').one('load',function(){
            page_photo(1);
        });
        $("#picbutt").click();
        //page_photo(1);
        return url ;
    }
}
function setpic(obj){
    $("#fileUp").click();
}
function dragStar(obj) {
    obj.dataTransfer.effectAllowed="copy";
    obj.dataTransfer.setData("id", obj.target.id);
}
function dragente(obj) {
    obj.dataTransfer.dropEffect="copy";
    obj.preventDefault();
}
function  dragove(obj) {
    obj.preventDefault();
}
function onDro(obj) {
    var tag_id = obj.target.id;
    var id = obj.dataTransfer.getData("id");
    event.preventDefault();
    $.post('/photos/drag_photo_tag',
        {
            tag_id:tag_id,
            photo_id:id
        },
        function (data, status) {
            if (status == 'success') {
                //alert("success");
                page_photo(1);
            } else {
                ;
            }
        });
}