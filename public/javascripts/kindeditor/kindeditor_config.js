        var editor;
        KindEditor.ready(function(K) {
                editor = K.create('#kindeditor',{ width : '700px',height:'500px', uploadJson : '/kindeditor/upload',
                fileManagerJson : '/kindeditor/images_list',
                allowFileManager : true});

        });