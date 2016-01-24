
/** @class_declaration prnusuario */
/////////////////////////////////////////////////////////////////
//// PRNUSUARIO /////////////////////////////////////////////////
class prnusuario extends oficial {
    function prnusuario( context ) { oficial ( context ); }
    function lanzarInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, etiquetas:Boolean, impDirecta:Boolean, whereFijo:String, nombreReport:String, numCopias:Number, impresora:String, pdf:Boolean) {
        return this.ctx.prnusuario_lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);
    }
}
//// PRNUSUARIO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prnusuario */
/////////////////////////////////////////////////////////////////
//// PRNUSUARIO /////////////////////////////////////////////////
function prnusuario_lanzarInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, etiquetas:Boolean, impDirecta:Boolean, whereFijo:String, nombreReport:String, numCopias:Number, impresora:String, pdf:Boolean)
{
    var util:FLUtil = new FLUtil();
    var idUsuario:String = sys.nameUser();
    var prnPredet:String = util.sqlSelect("usuarios","impresora","idusuario = '" + idUsuario + "'");

    // Si existe el usuario.
    if (prnPredet) {
        // Si la llamada es para env�o por correo-e el par�metro pdf ser� true y no avisar� de la prn predeterminada.
        if ((prnPredet.length > 0 || prnPredet) && !pdf) {
            var res:Number = MessageBox.warning(util.translate("scripts", "�Usar impresora predeterminada del usuario?\n"+prnPredet),MessageBox.Yes,  MessageBox.No);
            if (res == MessageBox.Yes) {
                impresora = prnPredet;
                // Por ahora, para compatibilidad con jasper-plugin, hay que desactivar la previsualizaci�n para que imprima por 
                //  la impresora asignada al usuario. 
                impDirecta = true;
            }
        }
    }

    ////////////////////////////////////////
    ////////////////////////////////////////
    //KLO. A PARTIR DE AQUI LLAMA A LA PADRE
    this.iface.__lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);

    return;
}
//// PRNUSUARIO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////

