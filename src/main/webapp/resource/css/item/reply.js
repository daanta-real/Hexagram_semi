$(function(){
    $(".view-row").find(".edit-btn").click(function(){
        $(this).parents("tr.view-row").hide();
        $(this).parents("tr.view-row").next("tr.edit-row").show();
    });
    
    $(".edit-row").find(".edit-cancel-btn").click(function(){
        $(this).parents("tr.edit-row").hide();
        $(this).parents("tr.edit-row").prev("tr.view-row").show();
    });
    

    $(".view-row").find(".reply-btn").click(function(){
        $(this).parents("tr.view-row").next("tr.edit-row").next("tr.reply-row").show();
    });			
        
    
    $(".reply-row").find(".reply-cancel-btn").click(function(){
        $(this).parents("tr.reply-row").hide();
    });
    
    $(".edit-row").hide();
    $(".reply-row").hide();
});