document.addEventListener("turbo:load", function () {
    $input = $("[data-behavior='programs-search']");

    var options = {
    getValue: "name",
    url: function(phrase) {
        return "/search_programs.json?q=" + phrase
    },
    categories: [
        {
            listlocation: "saved_items",
            header: "<strong>Programs</strong>",
        }
    ],
    list: {
        onChooseEvent: function() {
            var url = $input.getSelectedItemData().url;
            console.log(url);
        }
    }
    }

    $input.easyAutocomplete(options);
});