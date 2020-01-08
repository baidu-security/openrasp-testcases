<!DOCTYPE html>
<html>
    <head>
        <title>FreeMarker test</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        </head>
    <body>

        <table>
            <tr>
                <th>Name</th>
                <th>Price</th>
            </tr>

            <#list cars as car>
                <tr>
                    <td>${car.name}</td>
                    <td>${car.price}</td>
                </tr>
            </#list>
        </table>
    </body>
</html>