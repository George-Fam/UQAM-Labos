import java.util.List;

public class Etudiant {
   private String nom;
   private String codePermanent;
   private List<String> cours;
   
   public Etudiant(String nom, String codePermanent, List<String> cours) {
      this.nom = nom;
      this.codePermanent = codePermanent;
      this.cours = cours;
   }

   public String getNom() {
      return nom;
   }

   public String getCodePermanent() {
      return codePermanent;
   }

   public List<String> getCours() {
      return cours;
   }
}
