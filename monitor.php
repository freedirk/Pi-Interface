<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
       
        <title>Raspberry Pi Network Tool</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" href="css/bootstrap.css">

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
              <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
              <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
            <![endif]-->

    </head>
    <body>

        <!-- HEADER -->
        <header>
            <div class="jumbotron">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12">
                            <h1 class="text-center">Raspberry Pi Network Tool</h1>
                            <p class="text-center">A collection of open source tools designed to help a user get a picture of their network, and monitor network status.</p>
                            <p>&nbsp;</p>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- / HEADER --> 

        <!--  SECTION-1 -->
        <section>
            <div class="row">
                <div class="col-lg-12 page-header text-center">
                    <h2>Heartbeat Details</h2>
                </div>
            </div>
            <div class="container ">
                <div id="ping-data" class="">
                    <?php
                    $file = file_get_contents('pingout.txt', true);
                    $splitFile = explode(';', $file);
                    $array = array_chunk($splitFile, 3);
                    ?>
                    <table class="table table-striped">
                        <thead> 
                            <tr>
                                <th>Host Name</th>
                                <th>IP Address</th>
                                <th>Status</th>
                            </tr>  
                        </thead>
                        <tbody id="table-body">

                            <?php
                            $count = 0;
                            foreach ($array as $row) {
                                echo '<tr>';
                                foreach ($row as $item) {
                                    echo "<td>$item</td>";
                                }
                                echo '</tr>';
                            }
                            ?>
                            <tr></tr>
                        </tbody>
                    </table>
                   <div id="last-updated">Last Updated: <?= date($format) ?> </div>
                </div>
            </div>
        </div>


        <!-- /container -->

        <div class="container">
            <div class="row">
                <div class="col-lg-12 page-header text-center">

                    <p>The table above shows your essential services, their IP addresses and their status.</p>
                </div>
            </div>

        </div>
        <!-- / CONTAINER--> 
    </section>
    <div class="well"> </div>


    <footer class="text-center">
        <div class="container">
            <div class="row">
                <div class="col-xs-12">

                </div>
            </div>
        </div>
    </footer>
    <!-- / FOOTER --> 

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
    <script src="js/jquery.js"></script> 

    <script>
        var container = $('#ping-data'),
                table = $('#table-body'),
                timestamp = $('#last-updated');

        //chech ping.txt every 30 seconds
        setInterval(function () {
            $.ajax({
                url: "pingout.txt",
                async: false, 
                cache: false, 
                dataType: "text", 
                success: function (data, textStatus, jqXHR) {
                    var resourceContent = data.split(';'), arrays = [], size = 3, content = "";

                    timestamp.text('Last updated:' + new Date($.now()));
                    //now update table
           
                    while (resourceContent.length > 0) {
                        arrays.push(resourceContent.splice(0, size));
                    }

                    for (var i = 0; i < arrays.length; i++) {
                        content += "<tr>";

                        for (var j = 0; j < arrays[i].length; j++) {
                         
                            content += "<td>" + arrays[i][j] + "</td>";
                        }
                        content += "</tr>";
                    }
                    table.empty();
                    table.html(content);

                    console.log(content);

                }
            });



        }, 3000);

    </script>
    <!-- Include all compiled plugins (below), or include individual files as needed --> 
    <script src="js/bootstrap.js"></script>
</body>
</html>
