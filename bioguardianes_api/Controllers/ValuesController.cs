using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Formats.Asn1;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MySql.Data.MySqlClient;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace bioguardianes_api.Controllers

{
    public class ValuesController : Controller
    {
        private IConfiguration configuration;
        private string? connectionString;
        public ValuesController(IConfiguration iConfig)
        {
            configuration = iConfig;
            if (configuration.GetSection("ConnectionString").Value  == null )
            {
                throw new Exception("appsettings.json does not contain 'ConnectionString' key");
            } 
            else
            {
                connectionString = configuration.GetSection("ConnectionString").Value;
            }
        }

        public bool CheckExpiration(int biomonitor_id)
        {
            //check_deactivate
            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = ("check_deactivate");
            cmd.Parameters.AddWithValue("@biomonitor_id", biomonitor_id);

            // Define the output parameter for estado
            MySqlParameter outputParam = new("@estado", MySqlDbType.Bit)
            {
                Direction = ParameterDirection.Output
            };
            cmd.Parameters.Add(outputParam);

            cmd.ExecuteNonQuery();

            // Retrieve the value of the output parameter after executing the command
            bool estado = Convert.ToBoolean(cmd.Parameters["@estado"].Value);
            connection.Dispose();
            return estado;
        }


        [HttpGet("signin")]
        public int? GetSignIn([FromQuery]string correo, [FromQuery] string contrasena, [FromQuery] bool isAdmin = false)
        {

            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = (isAdmin ? "admin_sign_in" : "biomonitor_sign_in");

            cmd.Parameters.AddWithValue("@correo", correo);
            cmd.Parameters.AddWithValue("@contrasena", contrasena);
            int? res = null;

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    res = Convert.ToInt32(reader[isAdmin ? "administrador_id" : "biomonitor_id"]);
                    if (!isAdmin)
                    {
                        if (!CheckExpiration(res.Value))
                        {
                            res = null;
                        }
                    }
                }
            }
            connection.Dispose();
            return res;
        }

        public int? GetSignInBiomonitor(string correo, string contrasena)
        {
            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "biomonitor_sign_in";

            cmd.Parameters.AddWithValue("@correo", correo);
            cmd.Parameters.AddWithValue("@contrasena", contrasena);
            int? res = null;

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    res = Convert.ToInt32(reader["biomonitor_id"]);
                    if (!CheckExpiration(res.Value))
                    {
                        res = null;
                    }
                }
            }
            connection.Dispose();
            return res;
        }

        public int? GetSignInAdmin(string correo, string contrasena)
        {
            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "admin_sign_in";

            cmd.Parameters.AddWithValue("@correo", correo);
            cmd.Parameters.AddWithValue("@contrasena", contrasena);
            int? res = null;

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    res = Convert.ToInt32(reader["administrador_id"]);
                }
            }
            connection.Dispose();
            return res;
        }

        
        [HttpGet("signin_dashboard")]
        public SigninDashboard? GetSignInDashboard([FromQuery] string correo, [FromQuery] string contrasena)
        {
            int? id = null;
            if ((id = GetSignInAdmin(correo, contrasena)).HasValue)
            {
                return new()
                {
                    id = id.Value,
                    type = true
                };
            }
            if ((id = GetSignInBiomonitor(correo, contrasena)).HasValue)
            {
                return new()
                {
                    id = id.Value,
                    type = false
                };
            }
            return null;
        }

        [HttpGet("biomonitores_by_score")]
        public IEnumerable<BiomonitorScore> GetBiomonitoresByScore([FromQuery] int administrador_id)
        {
            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "get_biomonitores_by_score";
            cmd.Parameters.AddWithValue("@administrador_id", administrador_id);


            List<BiomonitorScore> biomonitors = new();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    BiomonitorScore biomonitor = new()
                    {
                        BiomonitorId = Convert.ToInt32(reader["biomonitor_id"]),
                        Puntuacion = Convert.ToInt32(reader["puntuacion"]),
                        Nombre = reader["nombre"]?.ToString() ?? "NULL",
                    };
                    biomonitors.Add(biomonitor);
                }
            }
            connection.Dispose();

            return biomonitors;
        }

        [HttpGet("biomonitores")]
        public IEnumerable<Biomonitor> GetBiomonitores()
        {
            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "get_biomonitores";


            List<Biomonitor> biomonitors = new();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    Biomonitor biomonitor = new()
                    {
                        BiomonitorId = Convert.ToInt32(reader["biomonitor_id"]),
                        AdministradorId = Convert.ToInt32(reader["administrador_id"]),
                        Nombre = reader["nombre"]?.ToString() ?? "NULL",
                        Apellidos = reader["apellidos"]?.ToString() ?? "NULL",
                        Correo = reader["correo"]?.ToString() ?? "NULL",
                        Telefono = reader["telefono"]?.ToString() ?? "NULL",
                        FechaNacimiento = reader["fecha_nacimiento"]?.ToString() ?? "NULL",
                        Ciudad = reader["ciudad"]?.ToString() ?? "NULL",
                        Estado = Convert.ToBoolean(reader["estado"])
                    };
                    biomonitors.Add(biomonitor);
                }
            }
            connection.Dispose();

            return biomonitors;
        }

        [HttpGet("biomonitores/{administrador_id}")]
        public IEnumerable<BiomonitorItem> GetBiomonitores(int administrador_id, [FromQuery] string search_string = "")
        {
            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "get_biomonitores_by_administrador";
            cmd.Parameters.AddWithValue("@administrador_id", administrador_id);
            cmd.Parameters.AddWithValue("@search_string", search_string);


            List<BiomonitorItem> biomonitors = new();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    BiomonitorItem biomonitor = new()
                    {
                        Id = Convert.ToInt32(reader["id"]),
                        Nombre = reader["nombre"]?.ToString() ?? "NULL",
                        Correo = reader["correo"]?.ToString() ?? "NULL",
                        Telefono = reader["telefono"]?.ToString() ?? "NULL",
                        Ciudad = reader["ciudad"]?.ToString() ?? "NULL",
                        Edad = Convert.ToInt32(reader["edad"])
                    };
                    biomonitors.Add(biomonitor);
                }
            }
            connection.Dispose();

            return biomonitors;
        }



        [HttpGet("biomonitor/{biomonitor_id}")]
        public Biomonitor GetBiomonitor(int biomonitor_id)
        {
            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "get_biomonitore_by_id";
            cmd.Parameters.AddWithValue("@biomonitor_id", biomonitor_id);

            Biomonitor biomonitor = new();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    biomonitor = new()
                    {
                        BiomonitorId = Convert.ToInt32(reader["biomonitor_id"]),
                        AdministradorId = Convert.ToInt32(reader["administrador_id"]),
                        Nombre = reader["nombre"]?.ToString() ?? "NULL",
                        Apellidos = reader["apellidos"]?.ToString() ?? "NULL",
                        Correo = reader["correo"]?.ToString() ?? "NULL",
                        Telefono = reader["telefono"]?.ToString() ?? "NULL",
                        FechaNacimiento = reader["fecha_nacimiento"]?.ToString() ?? "NULL",
                        Ciudad = reader["ciudad"]?.ToString() ?? "NULL",
                        Estado = Convert.ToBoolean(reader["estado"])
                    };
                }
            }
            connection.Dispose();

            return biomonitor;
        }

        [HttpGet("biomonitor_progress/{biomonitor_id}")]
        public List<NivelBiomonitor> GetLevelProgress(int biomonitor_id)
        {
            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "game_completion";
            cmd.Parameters.AddWithValue("@biomonitor_id", biomonitor_id);

            List<NivelBiomonitor> listaNivelBiomonitor = new();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    NivelBiomonitor nivelBiomonitor = new()
                    {
                        BiomonitorId = Convert.ToInt32(reader["biomonitor_id"]),
                        NivelId = Convert.ToInt32(reader["nivel_id"]),
                        Estrellas = Convert.ToInt32(reader["estrellas"]),
                        Insignia = Convert.ToBoolean(reader["insignia"]),
                        TiempoDedicado = Convert.ToInt32(reader["tiempo_dedicado"]),
                        PorcentajeDeTrivia = Convert.ToDouble(reader["porcentaje_de_trivia"]),
                        TutorialCompletado = Convert.ToInt32(reader["tutorial_completado"])
                    };
                    listaNivelBiomonitor.Add(nivelBiomonitor);
                }
            }
            connection.Dispose();

            return listaNivelBiomonitor;
        }
        [HttpPut("updateLevel/{biomonitor_id}/{nivel_id}")]
        public void PutLevel(int biomonitor_id, int nivel_id, [FromQuery] int estrellas = 0, [FromQuery] double porcentaje = 0,[FromQuery] int tiempo_dedicado = 0, [FromQuery] bool insignia = false, [FromQuery] bool tutorial_completado = false)
        {
            MySqlConnection connection = new MySqlConnection(connectionString);
            connection.Open();
            MySqlCommand cmd = new MySqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "update_biomonitor_level";
            cmd.Parameters.AddWithValue("@biomonitor_id", biomonitor_id);
            cmd.Parameters.AddWithValue("@nivel_id", nivel_id);
            cmd.Parameters.AddWithValue("@estrellas", estrellas);
            cmd.Parameters.AddWithValue("@porcentaje", porcentaje);
            cmd.Parameters.AddWithValue("@tiempo_dedicado", tiempo_dedicado);
            cmd.Parameters.AddWithValue("@insignia", insignia);
            cmd.Parameters.AddWithValue("@tutorial_completado", tutorial_completado);

            cmd.ExecuteNonQuery();
            connection.Dispose();
        }

        [HttpPut("deactivate_biomonitor")]
        public void DeactivateBiomonitor([FromBody] int biomonitor_id)
        {
            MySqlConnection connection = new MySqlConnection(connectionString);
            connection.Open();
            MySqlCommand cmd = new MySqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "deactivate_biomonitor";
            cmd.Parameters.AddWithValue("@biomonitor_id", biomonitor_id);

            cmd.ExecuteNonQuery();
            connection.Dispose();
        }

        [HttpGet("especies")]
        public IEnumerable<Especie> GetSpecies()
        {
            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "get_species";

            List<Especie> especies = new();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    Especie especie = new Especie
                    {
                        EspecieId = Convert.ToInt32(reader["id_especie"]),
                        NombreComun = reader["nombre_comun"] is DBNull ? "NULL" : Convert.ToString(reader["nombre_comun"]),
                        Descripcion = reader["descripcion"] is DBNull ? "NULL" : Convert.ToString(reader["descripcion"]),
                        Foto = reader["foto"] is DBNull ? "NULL" : Convert.ToString(reader["foto"]),
                        NombreCientifico = reader["nombre_cientifico"] is DBNull ? "NULL" : Convert.ToString(reader["nombre_cientifico"]),
                        Canto = reader["canto"] is DBNull ? "NULL" : Convert.ToString(reader["canto"]),
                        HabitosAlimenticios = reader["habitos_alimenticios"] is DBNull ? "NULL" : Convert.ToString(reader["habitos_alimenticios"]),
                        Habitat = reader["habitat"] is DBNull ? "NULL" : Convert.ToString(reader["habitat"]),
                        PesoPromedio = reader["peso_promedio"] is DBNull ? -1 : (float)Convert.ToDecimal(reader["peso_promedio"]),
                        DescripcionComportamiento = reader["descripcion_comportamiento"] is DBNull ? "NULL" : Convert.ToString(reader["descripcion_comportamiento"]),
                        Dieta = reader["dieta"] is DBNull ? "NULL" : Convert.ToString(reader["dieta"]),
                        Tipo = reader["tipo"] is DBNull ? "NULL" : Convert.ToString(reader["tipo"]),
                        Clima = reader["clima"] is DBNull ? "NULL" : Convert.ToString(reader["clima"])
                    };
                    especies.Add(especie);
                }
            }
            connection.Dispose();

            return especies;
        }

        [HttpGet("especie/{TipoEspecie}")]
        public IEnumerable<Especie> GetSpecie(string TipoEspecie)
        {
            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "get_specie_by_type";
            cmd.Parameters.AddWithValue("@TipoEspecie", TipoEspecie);

            List<Especie> especies = new();
            Especie especie = new();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    especie = new Especie
                    {
                        EspecieId = Convert.ToInt32(reader["id_especie"]),
                        NombreComun = reader["nombre_comun"] is DBNull ? "NULL" : Convert.ToString(reader["nombre_comun"]),
                        Descripcion = reader["descripcion"] is DBNull ? "NULL" : Convert.ToString(reader["descripcion"]),
                        Foto = reader["foto"] is DBNull ? "NULL" : Convert.ToString(reader["foto"]),
                        NombreCientifico = reader["nombre_cientifico"] is DBNull ? "NULL" : Convert.ToString(reader["nombre_cientifico"]),
                        Canto = reader["canto"] is DBNull ? "NULL" : Convert.ToString(reader["canto"]),
                        HabitosAlimenticios = reader["habitos_alimenticios"] is DBNull ? "NULL" : Convert.ToString(reader["habitos_alimenticios"]),
                        Habitat = reader["habitat"] is DBNull ? "NULL" : Convert.ToString(reader["habitat"]),
                        PesoPromedio = reader["peso_promedio"] is DBNull ? -1 : (float)Convert.ToDouble(reader["peso_promedio"]),
                        DescripcionComportamiento = reader["descripcion_comportamiento"] is DBNull ? "NULL" : Convert.ToString(reader["descripcion_comportamiento"]),
                        Dieta = reader["dieta"] is DBNull ? "NULL" : Convert.ToString(reader["dieta"]),
                        Tipo = reader["tipo"] is DBNull ? "NULL" : Convert.ToString(reader["tipo"]),
                        Clima = reader["clima"] is DBNull ? "NULL" : Convert.ToString(reader["clima"])
                    };
                    especies.Add(especie);
                }
            }
            connection.Dispose();

            return especies;
        }

        [HttpGet("especie_id/{EspecieId}")]
        public Especie GetSpecieById(int EspecieId)
        {
            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "get_specie_by_id";
            cmd.Parameters.AddWithValue("@EspecieId", EspecieId);

            Especie especie = new();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    especie = new()
                    {
                        EspecieId = Convert.ToInt32(reader["id_especie"]),
                        NombreComun = reader["nombre_comun"] is DBNull ? "NULL" : Convert.ToString(reader["nombre_comun"]),
                        Descripcion = reader["descripcion"] is DBNull ? "NULL" : Convert.ToString(reader["descripcion"]),
                        Foto = reader["foto"] is DBNull ? "NULL" : Convert.ToString(reader["foto"]),
                        NombreCientifico = reader["nombre_cientifico"] is DBNull ? "NULL" : Convert.ToString(reader["nombre_cientifico"]),
                        Canto = reader["canto"] is DBNull ? "NULL" : Convert.ToString(reader["canto"]),
                        HabitosAlimenticios = reader["habitos_alimenticios"] is DBNull ? "NULL" : Convert.ToString(reader["habitos_alimenticios"]),
                        Habitat = reader["habitat"] is DBNull ? "NULL" : Convert.ToString(reader["habitat"]),
                        PesoPromedio = reader["peso_promedio"] is DBNull ? -1 : (float)Convert.ToDecimal(reader["peso_promedio"]),
                        DescripcionComportamiento = reader["descripcion_comportamiento"] is DBNull ? "NULL" : Convert.ToString(reader["descripcion_comportamiento"]),
                        Dieta = reader["dieta"] is DBNull ? "NULL" : Convert.ToString(reader["dieta"]),
                        Tipo = reader["tipo"] is DBNull ? "NULL" : Convert.ToString(reader["tipo"]),
                        Clima = reader["clima"] is DBNull ? "NULL" : Convert.ToString(reader["clima"])
                    };
                }
            }
            connection.Dispose();

            return especie;
        }

        [HttpPost("registrar_biomonitor")]
        public int RegisterBiomonitor([FromBody] BiomonitorToRegister bm)
        {
            MySqlConnection connection = new MySqlConnection(connectionString);
            connection.Open();
            MySqlCommand cmd = new MySqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "registrar_biomonitor";

            cmd.Parameters.AddWithValue("@_administrador_id", bm.AdministradorId);
            cmd.Parameters.AddWithValue("@_nombre", bm.Nombre);
            cmd.Parameters.AddWithValue("@_apellidos", bm.Apellidos);
            cmd.Parameters.AddWithValue("@_correo", bm.Correo);
            cmd.Parameters.AddWithValue("@_telefono", bm.Telefono);
            cmd.Parameters.AddWithValue("@_fechaNacimiento", bm.FechaNacimiento);
            cmd.Parameters.AddWithValue("@_ciudad", bm.Ciudad);
			cmd.Parameters.AddWithValue("@_contrasena", bm.Contrasena);


			int id;

            using (var reader = cmd.ExecuteReader())
            {
                reader.Read();
                id = Convert.ToInt32(reader["biomonitor_id"]);
            }

            connection.Dispose();

            return id;
        }

        [HttpPost("registrar_biomonitor_sin_admin")]
        public int RegisterBiomonitorNoAdmin([FromBody] BiomonitorToRegister bm)
        {
			MySqlConnection connection = new MySqlConnection(connectionString);
			connection.Open();
			MySqlCommand cmd = new MySqlCommand();
			cmd.CommandType = CommandType.StoredProcedure;
			cmd.Connection = connection;
			cmd.CommandText = "registrar_biomonitor_temporal";

			cmd.Parameters.AddWithValue("@_administrador_id", 7);
			cmd.Parameters.AddWithValue("@_nombre", bm.Nombre);
			cmd.Parameters.AddWithValue("@_apellidos", bm.Apellidos);
			cmd.Parameters.AddWithValue("@_correo", bm.Correo);
			cmd.Parameters.AddWithValue("@_telefono", bm.Telefono);
			cmd.Parameters.AddWithValue("@_fechaNacimiento", bm.FechaNacimiento);
			cmd.Parameters.AddWithValue("@_ciudad", bm.Ciudad);
			cmd.Parameters.AddWithValue("@_contrasena", bm.Contrasena);

			int id;

			using (var reader = cmd.ExecuteReader())
			{
				reader.Read();
				id = Convert.ToInt32(reader["biomonitor_id"]);
			}

			connection.Dispose();

            return id;
		}
    }
}

