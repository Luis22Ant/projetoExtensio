using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace teste
{
    public class conexaoBanco
    {
        public static string Banco { get; set; } = "Projeto";
        public static string Login { get; set; } = "LUISPC\\Elton Oliveira";
        public static string Senha { get; set; } = "";
        public static string Servidor { get; set; } = "localhost\\SQLEXPRESS02";

        public static string ConexaoBanco()
        {
            return "server=" + Servidor + ";Database=" + Banco + ";UID=" + Login + ";PWD=" + Senha + ";Integrated Security=true";
        }
    }
}