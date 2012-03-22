        var editor;
        KindEditor.ready(function(K) {
                editor = K.create('#kindeditor',{ uploadJson : '/kindeditor/upload',
                fileManagerJson : '/kindeditor/images_list',
                allowFileManager : true});

        });