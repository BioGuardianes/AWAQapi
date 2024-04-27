using System;
namespace bioguardianes_api
{
	public class Administrador
	{
		public int AdministradorId { get; set; }
		public string Nombre { get; set; }
        public string Apellidos { get; set; }
        public string Correo { get; set; }

		public Administrador()
		{
			this.AdministradorId = 0;
			this.Nombre = "John";
            this.Apellidos = "Doe";
			this.Correo = "place@holder.com";
        }

    }

    public class BiomonitorToRegister
    {
		public int AdministradorId { get; set; }
		public string Nombre { get; set; }
		public string Apellidos { get; set; }
		public string Correo { get; set; }
		public string Telefono { get; set; }
		public string FechaNacimiento { get; set; }
		public string Ciudad { get; set; }
		public string Contrasena { get; set; }
	}

    public class Biomonitor
    {
        public int BiomonitorId { get; set; }
        public int AdministradorId { get; set; }
        public string Nombre { get; set; }
        public string Apellidos { get; set; }
        public string Correo { get; set; }
        public string Telefono { get; set; }
        public string FechaNacimiento { get; set; }
        public string Ciudad { get; set; }
        public bool Estado { get; set; }

        public Biomonitor()
        {
            this.BiomonitorId = 0;
            this.AdministradorId = 0;
            this.Nombre = "John";
            this.Apellidos = "Doe";
            this.Correo = "place@holder.com";
            this.Telefono = "0123456789";
            this.FechaNacimiento = "01-01-2000";
            this.Ciudad = "MTY";
            this.Estado = false;
        }

    }

    public class NivelBiomonitor
    {
        public int BiomonitorId { get; set; }
        public int NivelId { get; set; }
        public int Estrellas { get; set; }
        public bool Insignia { get; set; }
        public int TiempoDedicado { get; set; }
        public double PorcentajeDeTrivia { get; set; }
        public int TutorialCompletado { get; set; }

        public NivelBiomonitor()
        {
            this.BiomonitorId = 0;
            this.NivelId = 0;
            this.Estrellas = 0;
            this.Insignia = false;
            this.TiempoDedicado = 0;
            this.PorcentajeDeTrivia = 0.0;
            this.TutorialCompletado = 0;
        }

    }

    public class Especie
    {
        public int EspecieId { get; set; }
        public string NombreComun { get; set; }
        public string Descripcion { get; set; }
        public string Foto { get; set; }
        public string NombreCientifico { get; set; }
        public string Canto { get; set; }
        public string HabitosAlimenticios { get; set; }
        public string Habitat {  get; set; }
        public float PesoPromedio { get; set; }
        public string DescripcionComportamiento { get; set; }
        public string Dieta {  get; set; }
        public string Tipo {  get; set; }
        public string Clima {  get; set; }


        public Especie()
        {
            this.EspecieId = 0;
            this.NombreComun = "";
            this.Descripcion = "";
            this.Foto = "";
            this.NombreCientifico = "";
            this.Canto = "";
            this.HabitosAlimenticios = "";
            this.Habitat = "";
            this.PesoPromedio = 0;
            this.DescripcionComportamiento = "";
            this.Dieta = "";
            this.Tipo = "";
            this.Clima = "";
        }

    }

}

